#!/bin/bash

# List of packages to install/uninstall
packages="q"

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
    sudo mkdir -p /etc/apt/keyrings
    sudo curl -fsSL https://repo.natesales.net/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/natesales.gpg
    sudo echo "deb [signed-by=/etc/apt/keyrings/natesales.gpg] https://repo.natesales.net/apt * *" | sudo tee /etc/apt/sources.list.d/natesales.list
    sudo apt update && apt upgrade -y
    sudo apt install -y $packages
    echo "Packages installed."
fi
