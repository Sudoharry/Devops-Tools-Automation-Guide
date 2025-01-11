#!/bin/bash

# Script for installing Docker and Docker Compose V2 with error handling and colors

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

# Step 2: Install Docker
info "\nStep 2: Installing Docker..."
sudo apt install -y docker.io
if [ $? -ne 0 ]; then
  error "Error: Docker installation failed. Please ensure your system is up-to-date and try again."
  exit 1
fi

success "Docker installed successfully."

# Step 3: Install Docker Compose V2
info "\nStep 3: Installing Docker Compose V2..."
sudo apt install -y docker-compose-v2
if [ $? -ne 0 ]; then
  error "Error: Docker Compose V2 installation failed. Please ensure your system is up-to-date and try again."
  exit 1
fi

success "Docker Compose V2 installed successfully."

# Step 4: Verify Docker installation
info "\nStep 4: Verifying Docker installation..."
docker_version=$(docker --version 2>/dev/null)
if [ $? -ne 0 ]; then
  error "Error: Docker verification failed. Docker might not be installed correctly."
  exit 1
fi

success "Docker is installed: $docker_version"

# Step 5: Verify Docker Compose installation
info "\nStep 5: Verifying Docker Compose installation..."
docker_compose_version=$(docker compose version 2>/dev/null)
if [ $? -ne 0 ]; then
  error "Error: Docker Compose verification failed. Docker Compose might not be installed correctly."
  exit 1
fi

success "Docker Compose is installed: $docker_compose_version"

# Final Message
success "\nDocker and Docker Compose V2 installation completed successfully. Happy containerizing!"
