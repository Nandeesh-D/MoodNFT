# MoodNFT 🎭

**MoodNFT** is an on-chain ERC721 NFT project that reflects the **mood of the NFT owner**. Each NFT can toggle between two moods: **Happy** and **Sad**. The entire NFT metadata and SVG images are stored on-chain, ensuring the data is immutable and decentralized.

---

## Features ✨

- **Dynamic Mood Flipping**:  
  NFT owners can **flip the mood** of their NFT between **Happy** and **Sad**.

- **On-Chain Storage**:  
  Uses **OpenZeppelin's Base64 encoding** to store metadata and SVG images completely on-chain. No reliance on external storage solutions like IPFS.
  
- **Customizable Images**:  
  Mood-specific SVG images are set at deployment, allowing for unique and flexible designs.

- **100% Decentralized Metadata**:  
  Metadata, including name, description, attributes, and image URI, is stored fully on-chain in Base64 format.

---

## How It Works 🚀

1. **Minting**:  
   Users can mint a `MoodNFT`, which starts in the **Happy** mood by default.
   
2. **Mood Flipping**:  
   The owner can toggle the mood between **Happy** and **Sad** using the `flipMood` function.

3. **On-Chain Metadata**:  
   The `tokenURI` function encodes metadata as JSON and images as SVG directly into the blockchain.

---

## Setup 🛠️

### Prerequisites

- foundry installed
- openzeppelin contracts
- Set up your `.env` file with:
  - `SEPOLIA_RPC_URL`
  - `PRIVATE_KEY`
  - `ETHERSCAN_API_KEY`

### Installation

1. Install dependencies:  
   ```bash
   forge install

### Compilation
1. to compile the contracts:  
   ```bash
   forge compile

### Testing
1. to test the contracts:  
   ```bash
   forge test
2. to perform unit tests:
    ```bash
    forge test --mt testName


### Deployment
1. to deploy the contract:  
   ```bash
   forge script script/Deploy.s.sol:DeployMoodNFT --rpc-url ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY}--broadcast

### Contributing 🤝
Feel free to fork this repository, make improvements, and submit a pull request. Let's build the future of on-chain NFTs together!

### License 📜
This project is licensed under the MIT License.


