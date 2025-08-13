#!/usr/bin/env bash

ASTERISK_VERSION="22.5.1"


#Get Asterisk source code 
wget https://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk.${ASTERISK_VERSION}.tar.gz

#Extract the archive
tar -xzvf  asterisk.${ASTERISK_VERSION}.tar.gz

#Enter into directory 
cd asterisk.${ASTERISK_VERSION}.tar.gz


#Checking and install all the dependencies

echo "🛠️  Installing Asterisk prerequisites..."
sudo apt update
sudo apt install -y build-essential git \
    libxml2-dev libncurses5-dev uuid-dev libjansson-dev \
    libsqlite3-dev libedit-dev pkg-config libssl-dev \
    libsrtp2-dev curl wget



echo "📦 Installing optional dependencies..."
sudo ./contrib/scripts/install_prereq install

echo "⚙️  Configuring build..."
sudo ./configure --prefix=/usr --enable-shared --disable-sound --disable-resample --disable-video --disable-opencore-amr CFLAGS='-O2 -DNDEBUG'

echo "📋 Launching menuselect..."
sudo make menuselect

echo "🏗️  Compiling..."
sudo make -j$(nproc)
sudo make install
sudo make samples
sudo make config
echo "✅ Done! Run 'sudo make basic-pbx' for a quick get started configuration."

