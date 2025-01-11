#!/bin/bash

# Color codes for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No color

# Function to print messages in green
print_success() {
  echo -e "${GREEN}$1${NC}"
}

# Function to print messages in yellow
print_info() {
  echo -e "${YELLOW}$1${NC}"
}

# Function to print error messages in red
print_error() {
  echo -e "${RED}$1${NC}"
}

# Function to uninstall kubectl installed using curl method
uninstall_kubectl_from_curl() {
  print_info "Uninstalling kubectl installed via curl..."

  # Remove kubectl binary
  if [ -f /usr/local/bin/kubectl ]; then
    sudo rm -f /usr/local/bin/kubectl
    print_success "kubectl binary removed from /usr/local/bin"
  else
    print_error "kubectl binary not found in /usr/local/bin"
  fi

  # Remove checksum file if it exists
  if [ -f kubectl.sha256 ]; then
    rm -f kubectl.sha256
    print_success "kubectl checksum file removed"
  fi
}

# Function to uninstall kubectl installed using native package management (APT)
uninstall_kubectl_from_apt() {
  print_info "Uninstalling kubectl installed via APT..."

  # Remove kubectl using apt
  sudo apt-get remove -y kubectl
  sudo apt-get purge -y kubectl
  print_success "kubectl removed from system via APT"

  # Remove Kubernetes APT repository
  sudo rm -f /etc/apt/sources.list.d/kubernetes.list
  sudo rm -f /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  print_success "Kubernetes APT repository and signing key removed"
}

# Function to uninstall kubectl installed using Snap
uninstall_kubectl_from_snap() {
  print_info "Uninstalling kubectl installed via Snap..."

  # Remove kubectl using snap
  sudo snap remove kubectl
  print_success "kubectl removed from Snap"
}

# Welcome message
echo -e "${BLUE}==================== Kubernetes kubectl Uninstaller ====================${NC}"
echo -e "${BLUE}This script will help you uninstall kubectl from your Linux machine.${NC}"
echo

# Ask user for the installation method
echo -e "${YELLOW}Choose uninstallation method for kubectl:${NC}"
echo "1) Uninstall kubectl installed via curl (binary)"
echo "2) Uninstall kubectl installed via native package management (APT)"
echo "3) Uninstall kubectl installed via Snap"
echo

read -p "Enter choice (1/2/3): " choice

echo -e "${BLUE}=========================================================================${NC}"
echo

# Uninstall based on user's choice
case $choice in
  1)
    uninstall_kubectl_from_curl
    ;;
  2)
    uninstall_kubectl_from_apt
    ;;
  3)
    uninstall_kubectl_from_snap
    ;;
  *)
    print_error "Invalid choice. Exiting."
    exit 1
    ;;
esac

echo
print_info "Uninstallation complete! kubectl has been removed from your system."
