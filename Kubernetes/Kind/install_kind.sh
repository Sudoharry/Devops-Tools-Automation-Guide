#!/bin/bash

# Script for installing kind with requirement check, version check, and verification

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

# Function to check system requirements
check_requirements() {
  info "\nChecking system requirements..."

  # Check for curl
  if ! command -v curl &>/dev/null; then
    error "curl is not installed. Please install curl and try again."
    exit 1
  fi

  # Check for sudo permissions
  if [ "$EUID" -ne 0 ]; then
    error "This script requires sudo privileges. Please run as root or use sudo."
    exit 1
  fi

  success "All requirements are met."
}

# Step 1: Check requirements
check_requirements

# Step 2: Download kind binary for AMD64 / x86_64
info "\nStep 1: Downloading kind binary..."
if [ $(uname -m) = x86_64 ]; then
  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-amd64
elif [ $(uname -m) = aarch64 ]; then
  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-arm64
else
  error "Unsupported architecture: $(uname -m). Exiting."
  exit 1
fi

if [ $? -ne 0 ]; then
  error "Error: Failed to download kind. Please check your internet connection and try again."
  exit 1
fi

success "kind binary downloaded successfully."

# Step 3: Install kind binary
info "\nStep 2: Installing kind binary..."
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
if [ $? -ne 0 ]; then
  error "Error: Failed to install kind. Please try again."
  exit 1
fi

success "kind installed successfully."

# Step 4: Verify kind installation
info "\nStep 3: Verifying kind installation..."
kind_version=$(kind --version 2>/dev/null)
if [ $? -ne 0 ]; then
  error "Error: kind verification failed. Please check the installation and try again."
  exit 1
fi

success "kind is installed successfully. Version details:\n$kind_version"

# Step 5: Display happy message
success "\nHappy k8s :)"
