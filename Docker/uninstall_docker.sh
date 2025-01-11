#!/bin/bash

# Script for uninstalling Docker and Docker Compose V2 with error handling and colors

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

# Step 1: Uninstall Docker Compose V2
info "\nStep 1: Uninstalling Docker Compose V2..."
sudo apt remove -y docker-compose-v2
if [ $? -ne 0 ]; then
  error "Error: Failed to uninstall Docker Compose V2. Please check your system and try again."
  exit 1
fi

success "Docker Compose V2 uninstalled successfully."

# Step 2: Uninstall Docker
info "\nStep 2: Uninstalling Docker..."
sudo apt remove -y docker.io
if [ $? -ne 0 ]; then
  error "Error: Failed to uninstall Docker. Please check your system and try again."
  exit 1
fi

success "Docker uninstalled successfully."

# Step 3: Remove Docker-related directories
info "\nStep 3: Removing Docker-related directories..."
sudo rm -rf /var/lib/docker /etc/docker
sudo rm -rf /var/run/docker.sock
if [ $? -ne 0 ]; then
  error "Error: Failed to remove Docker-related directories. Please check your permissions."
  exit 1
fi

success "Docker-related directories removed successfully."

# Final Message
success "\nDocker and Docker Compose V2 uninstallation completed successfully."
