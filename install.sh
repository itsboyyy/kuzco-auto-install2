#!/bin/bash

set -e

# Disable interactive prompts
export DEBIAN_FRONTEND=noninteractive

echo ">>> Update & install dependencies..."
apt-get update -y && apt-get upgrade -y
apt-get install -y curl screen unzip git

echo ">>> Installing Bun..."
curl -fsSL https://bun.sh/install | bash

# Tambah ke PATH (kalau belum)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

echo ">>> Downloading kuzco installer..."
curl -fsSL https://raw.githubusercontent.com/danielgross/kuzco/main/install.sh -o setup-kuzco.sh
bash setup-kuzco.sh

echo ">>> Menjalankan worker di screen..."
screen -dmS kuzco-worker bash -c "kuzco worker start --worker 9_FMvrayCUk08zT9Kn3 --code 8c13928-beae-43b5-b259-3471361f0657"

echo ">>> Menambahkan ke crontab untuk auto start setelah reboot..."
(crontab -l 2>/dev/null; echo "@reboot screen -dmS kuzco-worker bash -c 'kuzco worker start --worker 9_FMvrayCUk08zT9Kn3 --code 8c13928-beae-43b5-b259-3471361f0657'") | crontab -

echo "✅ Instalasi selesai dan worker berjalan di screen session 'kuzco-worker'"

