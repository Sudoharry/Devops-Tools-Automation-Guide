#!/bin/bash

# Script for uninstalling kind and clearing logs

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

# Step 1: Uninstall kind
info "\nStep 1: Uninstalling kind..."

if command -v kind &>/dev/null; then
  sudo rm -f /usr/local/bin/kind
  if [ $? -ne 0 ]; then
    error "Error: Failed to uninstall kind. Please try again."
    exit 1
  fi
  success "kind uninstalled successfully."
else
  error "kind is not installed on your system."
fi

# Step 2: Clear kind-related logs
info "\nStep 2: Clearing kind logs..."
if [ -d "$HOME/.kube" ]; then
  rm -rf "$HOME/.kube"
  if [ $? -ne 0 ]; then
    error "Error: Failed to clear kind logs. Please try again."
    exit 1
  fi
  success "kind logs cleared successfully."
else
  info "No kind-related logs found to clear."
fi

# Step 3: Final message
success "\nkind has been uninstalled and logs cleared."
