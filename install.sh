#!/bin/bash

# Auto Install Script for Kuzco - by itsboyyy

# Update and install required packages
apt update && apt upgrade -y
apt install -y curl screen unzip git

# Install Bun
curl -fsSL https://bun.sh/install | bash

# Add Bun to PATH
echo 'export PATH="$HOME/.bun/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.bun/bin:$PATH"

# Install Kuzco CLI
curl -fsSL https://inference.supply/install.sh | sh

# Jalankan worker di dalam screen session
screen -dmS kuzco-worker bash -c "kuzco worker start --worker k8v9gukzt6hksA5utzDma --code 03471fed-a7b4-4537-a6f4-c7260646ce97"

# Tambahkan auto start ke crontab @reboot
(crontab -l 2>/dev/null; echo "@reboot screen -dmS kuzco-worker bash -c 'kuzco worker start --worker k8v9gukzt6hksA5utzDma --code 03471fed-a7b4-4537-a6f4-c7260646ce97'") | crontab -

echo ""
echo "✅ Instalasi selesai dan worker telah dijalankan di screen session 'kuzco-worker'"
echo "🔁 Worker juga akan otomatis dijalankan ulang setiap VPS boot"

