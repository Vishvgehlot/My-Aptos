module MyModule::DynamicStaking {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::timestamp;

    /// Struct to track staker's deposit and start time.
    struct Stake has store, key {
        amount: u64,
        start_time: u64,
    }

    /// Struct to store MintCapability for AptosCoin.
    struct MintHolder has store, key {
        capability: coin::MintCapability<AptosCoin>,
    }

    /// Function to stake tokens, recording the staked amount and start time.
    public fun stake_tokens(user: &signer, amount: u64) {
        let current_time = timestamp::now_seconds();
        let stake = Stake {
            amount,
            start_time: current_time,
        };

        // Withdraw the staked amount from the user's account.
        let withdrawal = coin::withdraw<AptosCoin>(user, amount);

        // Consume the withdrawn amount for staking by depositing it back.
        coin::deposit<AptosCoin>(signer::address_of(user), withdrawal);

        // Move the stake struct to the user's account.
        move_to(user, stake);
    }

    /// Function to claim rewards based on staked time.
    public fun claim_rewards(user: &signer) acquires Stake, MintHolder {
        let stake = borrow_global_mut<Stake>(signer::address_of(user));
        let current_time = timestamp::now_seconds();

        // Calculate rewards based on the staked time and amount.
        let staked_duration = current_time - stake.start_time;
        let reward_amount = calculate_reward(stake.amount, staked_duration);

        // Access the MintHolder to retrieve the MintCapability.
        let mint_holder = borrow_global<MintHolder>(signer::address_of(user));

        // Mint the reward using the MintCapability.
        let reward = coin::mint<AptosCoin>(reward_amount, &mint_holder.capability);

        // Deposit the reward into the user's account.
        coin::deposit<AptosCoin>(signer::address_of(user), reward);

        // Reset stake information (optional).
        stake.amount = 0;
        stake.start_time = 0;
    }

    /// Internal helper function to calculate rewards based on time.
    fun calculate_reward(amount: u64, duration: u64): u64 {
        // Example: 1% reward per 1000 seconds staked.
        amount * duration / 100_000
    }

    /// Function to initialize the MintHolder with an existing MintCapability.
    public fun initialize_mint_holder(owner: &signer, capability: coin::MintCapability<AptosCoin>) {
        let mint_holder = MintHolder {
            capability,
        };
        move_to(owner, mint_holder);
    }
}
