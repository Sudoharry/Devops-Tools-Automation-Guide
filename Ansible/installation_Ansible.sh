#!/bin/bash

# Script for installing Ansible with error handling and colors

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

# Step 1: Update the package list
info "\nStep 1: Updating the package list..."
sudo apt update
if [ $? -ne 0 ]; then
  error "Error: Failed to update the package list. Please check your network connection."
  exit 1
fi

success "Package list updated successfully."

# Step 2: Install software-properties-common
info "\nStep 2: Installing software-properties-common..."
sudo apt install -y software-properties-common
if [ $? -ne 0 ]; then
  error "Error: Failed to install software-properties-common. Please try again."
  exit 1
fi

success "software-properties-common installed successfully."

# Step 3: Add Ansible PPA
info "\nStep 3: Adding the Ansible PPA..."
sudo add-apt-repository --yes --update ppa:ansible/ansible
if [ $? -ne 0 ]; then
  error "Error: Failed to add the Ansible PPA. Please check your network connection and try again."
  exit 1
fi

success "Ansible PPA added successfully."

# Step 4: Install Ansible
info "\nStep 4: Installing Ansible..."
sudo apt install -y ansible
if [ $? -ne 0 ]; then
  error "Error: Failed to install Ansible. Please try again."
  exit 1
fi

success "Ansible installed successfully."

# Step 5: Verify Ansible installation
info "\nStep 5: Verifying Ansible installation..."
ansible_version=$(ansible --version 2>/dev/null)
if [ $? -ne 0 ]; then
  error "Error: Failed to verify Ansible installation. Please check the installation and try again."
  exit 1
fi

success "Ansible is installed successfully. Version details:\n$ansible_version"

# Final Message
success "\nAnsible installation completed successfully. You can now use Ansible for automation and configuration management."
