#!/bin/bash

# Color for messages
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

# Install Terraform
step_header "Installing Terraform..."

# Step 1: Download and install the GPG key
echo "Step 1: Downloading HashiCorp's GPG key..."
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg -y

# Step 2: Add HashiCorp repository
echo "Step 2: Adding HashiCorp repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Step 3: Update apt repository and install Terraform
echo "Step 3: Installing Terraform..."
sudo apt update
sudo apt install -y terraform

# Verify installation
step_header "Verifying Terraform installation..."
terraform -v

echo -e "${GREEN}Terraform installation complete!${RESET}"
