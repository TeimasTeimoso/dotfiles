#!/bin/sh

# Author: Ruben Teimas (@TeimasTeimoso)

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root (sudo ./setup_suse.sh)"
	exit 1
fi

echo "Refreshing repositories and performing distribution upgrade..."
zypper ref && zypper dup -y

echo "Installing new packages..."
bash bin/install_packages.sh
if [ $? -ne 0 ]; then
    echo "Failed to install packages. Please check the logs."
    exit 1
fi

echo "Copying configuration files..."
bash bin/copy_configs.sh configs
hyprctl reload

echo "Installing Spotify client through easyrpm..."
spotify-easyrpm --quiet

echo "Configuring Docker to run on startup..."
systemctl enable docker.service
usermod -aG docker "$USER"

