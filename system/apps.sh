#!/bin/bash

curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --version latest
rm ./dotnet-install.sh

sudo add-apt-repository --remove ppa:yann1ck/onedrive

sudo apt-get update
sudo apt-get install -y --no-install-recommends --no-install-suggests onedrive

sudo apt-get install -y \
    zlib1g \
    vlc \
    curl \
    git \
    unzip \
    iptables-persistent \
    qbittorrent \
    libxcb-xinerama0 libxcb-cursor0 libnss3 \
    zstd \
    htop \
    mpv \
    tlp \
    xclip \
    unrar \
    obs-studio \
    onevpl-tools \
    libmfx-gen1.2 \
    neovim \
    nodejs \
    luarocks \
    partitionmanager

sudo snap install todoist
sudo snap install obsidian --classic
sudo snap install rider --classic
sudo snap install discord
sudo snap install signal-desktop
sudo snap install telegram-desktop
sudo snap install steam
sudo snap install slack
sudo snap install yt-dlp

sudo dpkg --configure -a

dotnet tool install -g fsautocomplete

echo "Done!"
