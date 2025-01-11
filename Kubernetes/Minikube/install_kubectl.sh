#!/bin/bash

# Exit immediately if any command fails
set -e

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

# Function to install kubectl using curl method
install_kubectl_with_curl() {
  print_info "Installing kubectl using curl method..."

  # Set the version to install, you can change this to any desired version
  K8S_VERSION="v1.32.0"

  # Download kubectl binary
  print_info "Downloading kubectl version $K8S_VERSION..."
  curl -LO "https://dl.k8s.io/release/$K8S_VERSION/bin/linux/amd64/kubectl"

  # Validate the binary checksum
  print_info "Downloading checksum for kubectl..."
  curl -LO "https://dl.k8s.io/release/$K8S_VERSION/bin/linux/amd64/kubectl.sha256"

  # Validate checksum
  print_info "Validating checksum..."
  echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check --quiet

  # Install kubectl binary
  print_info "Installing kubectl to /usr/local/bin..."
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

  # Clean up
  rm kubectl.sha256

  # Verify kubectl installation
  print_success "kubectl installed successfully!"
  kubectl version --client
}

# Function to install kubectl using native package management for Debian-based systems
install_kubectl_with_apt() {
  print_info "Installing kubectl using native package management (APT)..."

  # Install dependencies
  print_info "Installing dependencies..."
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

  # Add Kubernetes public signing key
  print_info "Adding Kubernetes public signing key..."
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

  # Add the Kubernetes apt repository
  print_info "Adding Kubernetes apt repository..."
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list

  # Install kubectl
  print_info "Installing kubectl..."
  sudo apt-get update
  sudo apt-get install -y kubectl

  # Verify kubectl installation
  print_success "kubectl installed successfully!"
  kubectl version --client
}

# Function to install kubectl using Snap (alternative method)
install_kubectl_with_snap() {
  print_info "Installing kubectl using Snap..."

  # Install kubectl using Snap
  sudo snap install kubectl --classic

  # Verify kubectl installation
  print_success "kubectl installed successfully!"
  kubectl version --client
}

# Welcome message
echo -e "${BLUE}==================== Kubernetes kubectl Installer ====================${NC}"
echo -e "${BLUE}This script will help you install kubectl on your Linux machine.${NC}"
echo

# Ask user for the installation method
echo -e "${YELLOW}Choose installation method for kubectl:${NC}"
echo "1) Install using curl (specific version)"
echo "2) Install using native package management (APT)"
echo "3) Install using Snap"
echo

read -p "Enter choice (1/2/3): " choice

echo -e "${BLUE}=========================================================================${NC}"
echo

# Install based on user's choice
case $choice in
  1)
    install_kubectl_with_curl
    ;;
  2)
    install_kubectl_with_apt
    ;;
  3)
    install_kubectl_with_snap
    ;;
  *)
    print_error "Invalid choice. Exiting."
    exit 1
    ;;
esac

echo
print_info "Installation complete! You can now start using kubectl."
