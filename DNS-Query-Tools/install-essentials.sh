#!/bin/bash

# List of packages to install/uninstall
packages="curl wget nano dnsutils dnsenum"

# Check if the packages are already installed
dpkg -s $packages > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Packages are already installed."
    read -p "Do you want to uninstall them? (y/n): " choice
    if [ "$choice" == "y" ]; then
        echo "Uninstalling packages..."
        sudo apt remove --purge -y $packages
        sudo apt autoremove -y
        echo "Packages removed."
    else
        echo "No changes made."
    fi
else
    echo "Updating system and installing packages..."
    sudo apt update && apt upgrade -y
    sudo apt install -y $packages
    echo "Packages installed."
fi
