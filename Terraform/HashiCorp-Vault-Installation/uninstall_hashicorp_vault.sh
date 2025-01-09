#!/bin/bash

# Color for messages
RED="\033[1;31m"
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RESET="\033[0m"

# Function to display step header with color
step_header() {
  echo -e "${BLUE}## $1 ##${RESET}"
}

# Uninstall Vault and related tools
step_header "Uninstalling HashiCorp tools (Vault)..."
sudo apt remove --purge -y vault

# Remove HashiCorp repository and GPG key
step_header "Removing HashiCorp repository and GPG key..."
sudo rm -f /etc/apt/sources.list.d/hashicorp.list
sudo rm -f /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Clean up residual package data
step_header "Cleaning up residual packages..."
sudo apt autoremove -y
sudo apt clean

# Remove HashiCorp-related logs and data
step_header "Removing HashiCorp-related logs and data..."
rm -rf ~/.vault.d
rm -rf /var/log/vault*
rm -rf /etc/vault*

# Verify removal
step_header "Verifying Vault removal..."
vault -v
if [ $? -ne 0 ]; then
    echo -e "${GREEN}Vault has been successfully removed!${RESET}"
else
    echo -e "${RED}Vault removal failed! Please check the logs.${RESET}"
fi

echo -e "${GREEN}HashiCorp tool cleanup complete!${RESET}"
