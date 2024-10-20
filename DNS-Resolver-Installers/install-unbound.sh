#!/bin/bash

# Variables
package="unbound"
root_hints="/var/lib/unbound/root.hints"

# Check if Unbound is already installed
dpkg -s $package > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "$package is already installed."
    read -p "Do you want to uninstall $package and remove the root.hints file? (y/n): " choice
    if [ "$choice" == "y" ]; then
        echo "Uninstalling $package and removing root.hints..."
        sudo apt remove --purge -y $package
        sudo apt autoremove -y
        if [ -f "$root_hints" ]; then
            sudo rm "$root_hints"
            echo "root.hints removed."
        else
            echo "root.hints file already removed, or not added"
        fi
        echo "$package and uninstalled."
    else
        echo "No changes made."
    fi
else
    echo "Installing $package and setting up root.hints..."
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y $package
    wget https://www.internic.net/domain/named.root -qO- | sudo tee "$root_hints"
    echo "Unbound and root.hints setup completed."
fi

