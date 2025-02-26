#!/bin/bash

# Variables
PACKAGE="unbound"
ROOT_HINTS="/var/lib/unbound/root.hints"

# Function to install Unbound and set up root.hints
install_unbound() {
    echo "Installing $PACKAGE and setting up root.hints..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y $PACKAGE

    if command -v wget >/dev/null 2>&1; then
        wget -qO- https://www.internic.net/domain/named.root | sudo tee "$ROOT_HINTS" >/dev/null
        echo "root.hints downloaded successfully."
    else
        echo "wget not found! Please install it manually and download root.hints."
    fi

    echo "Installation complete."
}

# Function to uninstall Unbound and remove root.hints
uninstall_unbound() {
    echo "Uninstalling $PACKAGE and removing root.hints..."
    sudo apt remove --purge -y $PACKAGE && sudo apt autoremove -y

    if [ -f "$ROOT_HINTS" ]; then
        sudo rm "$ROOT_HINTS"
        echo "root.hints removed."
    else
        echo "root.hints file not found."
    fi

    echo "Uninstallation complete."
}

# Check if Unbound is installed
if command -v unbound >/dev/null 2>&1; then
    echo "$PACKAGE is already installed."
    read -rp "Do you want to uninstall $PACKAGE and remove root.hints? (y/n): " choice
    case "$choice" in
        [Yy]) uninstall_unbound ;;
        *) echo "No changes made." ;;
    esac
else
    install_unbound
fi
