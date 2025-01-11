#!/bin/bash

# Script for uninstalling Minikube with requirement check and verification

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

  # Check for sudo permissions
  if [ "$EUID" -ne 0 ]; then
    error "This script requires sudo privileges. Please run as root or use sudo."
    exit 1
  fi

  success "All requirements are met."
}

# Step 1: Check requirements
check_requirements

# Step 2: Check if Minikube is installed
info "\nStep 1: Checking if Minikube is installed..."
if ! command -v minikube &>/dev/null; then
  error "Minikube is not installed. No need to uninstall."
  exit 1
fi

success "Minikube is installed. Proceeding with uninstallation."

# Step 3: Uninstall Minikube binary
info "\nStep 2: Uninstalling Minikube binary..."
sudo rm -f /usr/local/bin/minikube
if [ $? -ne 0 ]; then
  error "Error: Failed to uninstall Minikube binary. Please check the installation and try again."
  exit 1
fi

success "Minikube binary removed successfully."

# Step 4: Remove Minikube's configuration and data
info "\nStep 3: Removing Minikube configuration and data..."
rm -rf ~/.minikube
rm -rf ~/.kube/minikube
if [ $? -ne 0 ]; then
  error "Error: Failed to remove Minikube's configuration and data. Please check manually."
  exit 1
fi

success "Minikube's configuration and data removed successfully."

# Step 5: Verify Minikube uninstallation
info "\nStep 4: Verifying Minikube uninstallation..."
if command -v minikube &>/dev/null; then
  error "Error: Minikube was not fully uninstalled. Please check manually."
  exit 1
fi

success "Minikube has been uninstalled successfully."

