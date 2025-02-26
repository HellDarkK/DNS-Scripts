#!/bin/bash

# List of packages to install/uninstall
packages="curl wget nano dnsutils dnsenum"

# Ensure script runs as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo."
    exit 1
fi

# Check if any of the packages are installed
installed_packages=$(dpkg-query -W -f='${Status} ${Package}\n' $packages 2>/dev/null | grep "installed" | awk '{print $4}')

if [ -n "$installed_packages" ]; then
    echo "The following packages are already installed: $installed_packages"
    while true; do
        read -p "Do you want to uninstall them? (y/n): " choice
        case "$choice" in
            [Yy]*) 
                echo "Uninstalling packages..."
                sudo apt-get remove --purge -y $installed_packages
                sudo apt-get autoremove -y
                echo "Packages removed."
                break
                ;;
            [Nn]*) 
                echo "No changes made."
                break
                ;;
            *) 
                echo "Invalid input. Please enter y or n."
                ;;
        esac
    done
else
    echo "Updating system and installing packages..."
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y $packages
    echo "Packages installed."
fi
