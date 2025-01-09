# T3RN-Bridge-Testnet-v0.33.0-Executer Node

A step-by-step guide to set up and run the T3rn Executor Script for testing across various networks.

---

## 🚀 Preparation  

### 🛒 Purchase Sepolia ETH  
You can easily purchase **ETH Sepolia** for testing using the following link:  
🔗 https://testnetbridge.com/sepolia
> **Note:** With just **$10**, you'll receive a generous amount of ETH for testing purposes.

---

### 🔄 Bridging ETH Sepolia  
Bridge your Sepolia ETH to different networks using the links below:

1. **Sepolia → ARB Sepolia**  
   🌐 https://bridge.arbitrum.io/

2. **Sepolia → BASE Sepolia**  
   🌐 https://superbridge.app/base-sepolia

3. **Sepolia → Sepolia Optimism**  
   🌐 https://superbridge.app/op-sepolia

4. **Sepolia → Sepolia BLAST**  
   Send Sepolia ETH directly to this address:  
   `0xc644cc19d2a9388b71dd1dede07cffc73237dca8`

> **Tip:** Transfer **10 ETH** to each network to ensure ample usage.

---

## 🧰 Setup Instructions  

### 1️⃣ Create an Alchemy or Infura Account  
- Sign up on either [Alchemy](https://www.alchemy.com/) or [Infura](https://www.infura.io/).  
- Retrieve the **RPC URL** for the relevant networks.

### 2️⃣ Prepare Your Wallet  
Ensure your wallet has a sufficient balance on the following networks:  
- **ETH OP Sepolia**  
- **ETH Arb Sepolia**  
- **ETH Base Sepolia**  
- **ETH Sepolia BLAST**  
- **Token BRN**

### 3️⃣ Get BRN Tokens  
Claim **BRN tokens** for testing via the faucet:  
🌐 https://faucet.brn.t3rn.io/
> Connect your MetaMask wallet to access the faucet.

### 4️⃣ Check Your BRN Balance  
- Visit the BRN Explorer:  
  🌐 https://brn.explorer.caldera.xyz/
- Enter your wallet address to view your token balance.

---

## 🛠️ Running the Script  

### Ensure the Script is in the Root Directory  
Run the following command to auto-install and execute the script:  
```bash
wget https://raw.githubusercontent.com/hardeeps647/t3rn_guide/main/t3rn_executor.sh && chmod +x t3rn_executor.sh && ./t3rn_executor.sh
```

---

## 📊 Monitoring and Dashboard  

### View Service Logs  
Check the logs of the T3rn Executor service with this command:  
```bash
sudo journalctl -u t3rn-executor.service -f --no-hostname -o cat
```

### Access the Node Reward Dashboard  
Visit the reward dashboard by replacing `Your_Wallet_Address` with your actual wallet address:  
🌐 https://bridge.t1rn.io/executor/**Your_Wallet_Address**

---
