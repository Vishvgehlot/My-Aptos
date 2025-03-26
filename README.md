# Dynamic Staking Module

## Description
The **Dynamic Staking Module** is a smart contract built on the **Move** language, enabling users to stake their Aptos tokens ($APT) and earn rewards based on the duration of their stake. The system ensures secure deposits, dynamic reward calculations, and the ability to claim earned rewards efficiently.

## Vision
The vision of this module is to provide a **decentralized and automated staking mechanism** that encourages long-term token holding while ensuring fair reward distribution. This module aims to create a sustainable staking economy that benefits both stakers and the ecosystem.

## Future Scope
1. **Flexible Reward Rates** – Implement variable reward rates based on staking durations or market conditions.
2. **Penalty System** – Introduce penalties for early withdrawals to encourage long-term staking.
3. **Multi-token Support** – Extend the module to support other tokens apart from AptosCoin.
4. **Auto-Compounding** – Allow users to automatically reinvest their rewards for compounded growth.
5. **Governance Mechanism** – Enable token holders to vote on staking parameters and reward adjustments.

## Contract Details

### **Stake Tokens**
- **Function:** `stake_tokens(user: &signer, amount: u64)`
- **Purpose:** Allows users to stake a specified amount of Aptos tokens.
- **Process:**
  - Records the staking amount and start time.
  - Withdraws the amount from the user's account.
  - Deposits it back into the staking contract.

### **Claim Rewards**
- **Function:** `claim_rewards(user: &signer)`
- **Purpose:** Allows users to claim staking rewards based on the duration of their stake.
- **Process:**
  - Calculates rewards using the formula: `reward = amount * duration / 100_000`.
  - Mints new Aptos tokens as rewards.
  - Deposits the reward tokens into the user's account.
  - Resets stake information after claim.

### **Initialize Mint Holder**
- **Function:** `initialize_mint_holder(owner: &signer, capability: coin::MintCapability<AptosCoin>)`
- **Purpose:** Initializes the contract with minting capabilities for reward distribution.
- **Process:**
  - Stores the minting capability inside the contract for future reward minting.

### **Reward Calculation**
- **Formula:** `reward = amount * duration / 100_000`
- **Example:** If a user stakes **100 APT** for **10,000 seconds**, the reward would be `100 * 10,000 / 100,000 = 10 APT`.

## How to Use
1. **Deploy the contract** on the Aptos blockchain.
2. **Initialize MintHolder** by calling `initialize_mint_holder()`.
3. **Users stake tokens** using `stake_tokens()`.
4. **Users claim rewards** using `claim_rewards()` after staking for a period.

## Dependencies
- **Move Language** – Smart contract development.
- **Aptos Framework** – For handling coin transactions, timestamps, and signer authentication.
- **AptosCoin** – The staking and reward token.

## License
This project is open-source and available under the MIT License.

---
This document provides an overview of the **Dynamic Staking Module**, outlining its functionalities, vision, and future enhancements.

