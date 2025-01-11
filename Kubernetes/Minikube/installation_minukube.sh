#!/bin/bash

# Script for installing Minikube with requirement check and verification

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

# Step 2: Download Minikube binary
info "\nStep 1: Downloading Minikube binary..."
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
if [ $? -ne 0 ]; then
  error "Error: Failed to download Minikube. Please check your internet connection and try again."
  exit 1
fi

success "Minikube binary downloaded successfully."

# Step 3: Install Minikube
info "\nStep 2: Installing Minikube..."
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
if [ $? -ne 0 ]; then
  error "Error: Failed to install Minikube. Please try again."
  exit 1
fi

success "Minikube installed successfully."

# Step 4: Verify Minikube installation
info "\nStep 3: Verifying Minikube installation..."
minikube_version=$(minikube version 2>/dev/null)
if [ $? -ne 0 ]; then
  error "Error: Minikube verification failed. Please check the installation and try again."
  exit 1
fi

success "Minikube is installed successfully. Version details:\n$minikube_version"

# Final Message
success "\nMinikube installation completed successfully. Happy K8s!"
