#!/bin/bash

echo "\n
╔═╗╔═╗╔═══╗╔═╗ ╔╗╔═══╗╔═══╗╔═══╗╔═══╗╔════╗    ╔═══╗╔╗ ╔╗╔═══╗╔╗   ╔══╗╔╗╔╗╔╗╔═══╗╔╗   
║║╚╝║║║╔═╗║║║╚╗║║║╔═╗║║╔═╗║║╔══╝║╔══╝║╔╗╔╗║    ╚╗╔╗║║║ ║║║╔═╗║║║   ╚╣╠╝║║║║║║║╔═╗║║║   
║╔╗╔╗║║║ ║║║╔╗╚╝║║╚═╝║║╚═╝║║╚══╗║╚══╗╚╝║║╚╝     ║║║║║╚═╝║║║ ║║║║    ║║ ║║║║║║║║ ║║║║   
║║║║║║║╚═╝║║║╚╗║║║╔══╝║╔╗╔╝║╔══╝║╔══╝  ║║       ║║║║║╔═╗║║╚═╝║║║ ╔╗ ║║ ║╚╝╚╝║║╚═╝║║║ ╔╗
║║║║║║║╔═╗║║║ ║║║║║   ║║║╚╗║╚══╗║╚══╗ ╔╝╚╗     ╔╝╚╝║║║ ║║║╔═╗║║╚═╝║╔╣╠╗╚╗╔╗╔╝║╔═╗║║╚═╝║
╚╝╚╝╚╝╚╝ ╚╝╚╝ ╚═╝╚╝   ╚╝╚═╝╚═══╝╚═══╝ ╚══╝     ╚═══╝╚╝ ╚╝╚╝ ╚╝╚═══╝╚══╝ ╚╝╚╝ ╚╝ ╚╝╚═══╝
\n"

# Remove existing 'executor' directory if it exists
rm -rf executor

# Download and extract the executor binary
curl -L -o executor-linux-v0.33.0.tar.gz \
  https://github.com/t3rn/executor-release/releases/download/v0.33.0/executor-linux-v0.33.0.tar.gz && \
tar -xzvf executor-linux-v0.33.0.tar.gz && \
rm -f executor-linux-v0.33.0.tar.gz && \
cd executor/executor/bin || exit

# Prompt user for necessary configuration inputs
read -p "Enter your PRIVATE_KEY_LOCAL: " PRIVATE_KEY_LOCAL
read -p "Enter RPC_ENDPOINTS ARB SEPOLIA RPC: " RPC_ENDPOINTS_ARBT
read -p "Enter RPC_ENDPOINTS BASE SEPOLIA RPC: " RPC_ENDPOINTS_BSSP
read -p "Enter RPC_ENDPOINTS BLAST SEPOLIA RPC: " RPC_ENDPOINTS_BLSS
read -p "Enter RPC_ENDPOINTS OPTIMISM SEPOLIA RPC: " RPC_ENDPOINTS_OPSP
read -p "Enter EXECUTOR_MAX_L3_GAS_PRICE (default 10): " EXECUTOR_MAX_L3_GAS_PRICE
EXECUTOR_MAX_L3_GAS_PRICE=${EXECUTOR_MAX_L3_GAS_PRICE:-10} # Default to 10 if not provided

# Generate systemd service file dynamically
sudo tee /etc/systemd/system/t3rn-executor.service > /dev/null <<EOF
[Unit]
Description=T3rn Executor Service
After=network.target

[Service]
ExecStart=/root/executor/executor/bin/executor
Environment="NODE_ENV=testnet"
Environment="LOG_LEVEL=debug"
Environment="LOG_PRETTY=false"
Environment="EXECUTOR_PROCESS_ORDERS=true"
Environment="EXECUTOR_PROCESS_CLAIMS=true"
Environment="PRIVATE_KEY_LOCAL=$PRIVATE_KEY_LOCAL"
Environment="ENABLED_NETWORKS=arbitrum-sepolia,base-sepolia,blast-sepolia,optimism-sepolia,l1rn"
Environment="RPC_ENDPOINTS_ARBT=$RPC_ENDPOINTS_ARBT"
Environment="RPC_ENDPOINTS_BSSP=$RPC_ENDPOINTS_BSSP"
Environment="RPC_ENDPOINTS_BLSS=$RPC_ENDPOINTS_BLSS"
Environment="RPC_ENDPOINTS_OPSP=$RPC_ENDPOINTS_OPSP"
Environment="EXECUTOR_MAX_L3_GAS_PRICE=$EXECUTOR_MAX_L3_GAS_PRICE"
Restart=always
RestartSec=5
User=$USER

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start the executor service
sudo systemctl daemon-reload
sudo systemctl enable t3rn-executor.service
sudo systemctl start t3rn-executor.service

# Display real-time service logs
sudo journalctl -u t3rn-executor.service -f --no-hostname -o cat
