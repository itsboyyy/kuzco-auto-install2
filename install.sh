#!/bin/bash

# Auto Install Script for Kuzco - by itsboyyy

# Update and install required packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl screen unzip git

# Install Bun
curl -fsSL https://bun.sh/install | bash

# Apply Bun to PATH (assumes Bash)
echo "export PATH=\"\$HOME/.bun/bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc

# Install Kuzco CLI
curl -fsSL https://inference.supply/install.sh | sh

# Start a screen session named kuzco-worker
screen -dmS kuzco-worker bash -c "kuzco worker start --worker k8v9gukzt6hksA5utzDma --code 03471fed-a7b4-4537-a6f4-c7260646ce97"

