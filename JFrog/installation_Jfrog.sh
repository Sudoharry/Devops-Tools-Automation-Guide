#!/bin/bash

# Define color variables
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'  # No Color

# Update Ubuntu OS
echo -e "${YELLOW}Updating Ubuntu OS...${NC}"
sudo apt update || { echo -e "${RED}Failed to update apt${NC}"; exit 1; }

# Add JFrog Artifactory APT repository
echo -e "${YELLOW}Adding JFrog Artifactory APT repository...${NC}"
echo "deb https://releases.jfrog.io/artifactory/artifactory-debs xenial main" | sudo tee /etc/apt/sources.list.d/artifactory.list

# Import repository GPG key securely
echo -e "${YELLOW}Importing repository GPG key...${NC}"
curl -fsSL https://releases.jfrog.io/artifactory/api/gpg/key/public | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/artifactory.gpg || { echo -e "${RED}Failed to import GPG key${NC}"; exit 1; }

# Update package list again
echo -e "${YELLOW}Updating package list...${NC}"
sudo apt update || { echo -e "${RED}Failed to update apt after adding repository${NC}"; exit 1; }

# Install Artifactory
echo -e "${YELLOW}Installing JFrog Artifactory OSS...${NC}"
sudo apt install jfrog-artifactory-oss -y || { echo -e "${RED}Failed to install JFrog Artifactory${NC}"; exit 1; }

# Start Artifactory service
echo -e "${YELLOW}Starting Artifactory service...${NC}"
sudo systemctl start artifactory.service || { echo -e "${RED}Failed to start Artifactory service${NC}"; exit 1; }

# Enable Artifactory service to start on boot
echo -e "${YELLOW}Enabling Artifactory service to start on boot...${NC}"
sudo systemctl enable artifactory.service || { echo -e "${RED}Failed to enable Artifactory service${NC}"; exit 1; }

echo -e "${GREEN}JFrog Artifactory installation completed successfully.${NC}"

