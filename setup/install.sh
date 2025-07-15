#!/usr/bin/env bash

echo "🛠️  Installing Asterisk prerequisites..."
sudo apt update
sudo apt install -y build-essential git \
    libxml2-dev libncurses5-dev uuid-dev libjansson-dev \
    libsqlite3-dev libedit-dev pkg-config libssl-dev \
    libsrtp2-dev curl wget

cd /usr/src || exit

echo "📥 Cloning Asterisk source..."
sudo git clone -b 20 https://gerrit.asterisk.org/asterisk
cd asterisk || exit

echo "📦 Installing optional dependencies..."
sudo contrib/scripts/install_prereq install

echo "⚙️  Configuring build..."
sudo ./configure

echo "📋 Launching menuselect..."
sudo make menuselect

echo "🏗️  Compiling..."
sudo make -j$(nproc)
sudo make install
sudo make samples
sudo make config

echo "🚀 Starting Asterisk..."
sudo systemctl enable asterisk
sudo systemctl start asterisk

echo "✅ Done! Run 'sudo asterisk -rvvv' to access the CLI."


