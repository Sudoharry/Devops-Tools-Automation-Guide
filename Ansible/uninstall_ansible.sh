#!/bin/bash

# Script for uninstalling Ansible and cleaning up related logs

# Define colors
GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"
RESET="\e[0m"

# Function to print success messages
success() {
  echo -e "${GREEN}$1${RESET}"
}

# Function to print error messages
error() {
  echo -e "${RED}$1${RESET}"
}

# Function to print info messages
info() {
  echo -e "${CYAN}$1${RESET}"
}

# Step 1: Remove Ansible package
info "\nStep 1: Removing Ansible package..."
sudo apt remove -y ansible
if [ $? -ne 0 ]; then
  error "Error: Failed to remove Ansible. Please try again."
  exit 1
fi

success "Ansible removed successfully."

# Step 2: Remove Ansible PPA
info "\nStep 2: Removing Ansible PPA..."
sudo add-apt-repository --remove -y ppa:ansible/ansible
if [ $? -ne 0 ]; then
  error "Error: Failed to remove the Ansible PPA. Please try again."
  exit 1
fi

success "Ansible PPA removed successfully."

# Step 3: Clean up logs and cached files
info "\nStep 3: Cleaning up logs and cached files..."
sudo apt autoremove -y
sudo apt clean
sudo rm -rf /var/log/ansible
if [ $? -ne 0 ]; then
  error "Error: Failed to clean up logs and cached files. Please check permissions and try again."
  exit 1
fi

success "Logs and cached files cleaned successfully."

# Step 4: Verify Ansible removal
info "\nStep 4: Verifying Ansible removal..."
if command -v ansible &>/dev/null; then
  error "Error: Ansible is still installed. Please check the removal steps and try again."
  exit 1
fi

success "Ansible has been completely uninstalled."

# Final Message
success "\nAnsible uninstallation completed successfully. System is clean."
