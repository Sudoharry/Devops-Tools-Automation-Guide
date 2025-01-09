#!/bin/bash

# Install GPG
echo -e "\033[1;34m## Step 1: Installing GPG... ##\033[0m"
sudo apt update && sudo apt install -y gpg

# Download the signing key to a new keyring
echo -e "\033[1;34m## Step 2: Downloading the HashiCorp signing key... ##\033[0m"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg -y

# Verify the key's fingerprint
echo -e "\033[1;34m## Step 3: Verifying the key's fingerprint... ##\033[0m"
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# Add the HashiCorp repository
echo -e "\033[1;34m## Step 4: Adding the HashiCorp repository... ##\033[0m"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update the repository
echo -e "\033[1;34m## Step 5: Updating the repository... ##\033[0m"
sudo apt update

# Install Vault
echo -e "\033[1;34m## Step 6: Installing Vault... ##\033[0m"
sudo apt install -y vault

# Start Vault server in dev mode
echo -e "\033[1;34m## Step 7: Starting Vault server in development mode... ##\033[0m"
vault server -dev -dev-listen-address="0.0.0.0:8200"

# Final message
echo -e "\033[1;32mVault installation and startup complete. Vault is running in development mode on 0.0.0.0:8200.\033[0m"
