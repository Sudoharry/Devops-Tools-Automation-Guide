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

# Update system
step_header "Updating system packages..."
sudo apt update

# Uninstall Terraform
step_header "Uninstalling Terraform..."
sudo apt remove --purge -y terraform

# Remove HashiCorp repository
step_header "Removing HashiCorp repository..."
sudo rm -f /etc/apt/sources.list.d/hashicorp.list

# Remove GPG key
step_header "Removing HashiCorp GPG key..."
sudo rm -f /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Clear package cache
step_header "Cleaning up package cache..."
sudo apt autoremove -y
sudo apt clean

# Clear Terraform related logs and data
step_header "Removing Terraform-related logs and data..."
rm -rf ~/.terraform.d
rm -rf ~/terraform
rm -rf /var/log/terraform*

# Verify removal of Terraform
step_header "Verifying Terraform removal..."
terraform -v
if [ $? -ne 0 ]; then
    echo -e "${GREEN}Terraform has been successfully removed!${RESET}"
else
    echo -e "${RED}Terraform removal failed! Please check the logs.${RESET}"
fi

echo -e "${GREEN}Terraform cleanup complete!${RESET}"
