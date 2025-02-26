#!/bin/bash

# List of packages to install/uninstall
packages="q"  # Replace 'q' with the actual package name

# Ensure script runs as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo."
    exit 1
fi

# Check if any of the packages are installed
installed_packages=$(dpkg-query -W -f='${Status} ${Package}\n' $packages 2>/dev/null | grep "installed" | awk '{print $4}')

if [ -n "$installed_packages" ]; then
    echo "The following packages are already installed: $installed_packages"
    read -p "Do you want to uninstall them? (y/n): " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        echo "Uninstalling packages..."
        sudo apt remove --purge -y $installed_packages
        sudo apt autoremove -y
        echo "Packages removed."
    else
        echo "No changes made."
    fi
else
    echo "Updating system and installing packages..."
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.natesales.net/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/natesales.gpg
    echo "deb [signed-by=/etc/apt/keyrings/natesales.gpg] https://repo.natesales.net/apt * *" | sudo tee /etc/apt/sources.list.d/natesales.list > /dev/null
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y $packages
    echo "Packages installed."
fi
