#!/bin/bash

# Color variables for better readability in dark mode
RED='\033[0;31m'     # Red for errors or important messages
GREEN='\033[0;32m'   # Green for success
YELLOW='\033[1;33m'  # Yellow for warnings or non-critical info
CYAN='\033[0;36m'    # Cyan for general info
RESET='\033[0m'      # Reset color

# Step 1: Install dependencies (wget, apt-transport-https, gnupg, lsb-release)
echo -e "${CYAN}Step 1: Installing dependencies (wget, apt-transport-https, gnupg, lsb-release)...${RESET}"

sudo apt-get install wget apt-transport-https gnupg lsb-release -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Dependencies installed successfully.${RESET}"
else
    echo -e "${RED}Failed to install dependencies.${RESET}"
    exit 1
fi

# Step 2: Add the Trivy GPG key to the system
echo -e "${CYAN}Step 2: Adding Trivy GPG key...${RESET}"

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Trivy GPG key added successfully.${RESET}"
else
    echo -e "${RED}Failed to add Trivy GPG key.${RESET}"
    exit 1
fi

# Step 3: Add Trivy repository to the sources list
echo -e "${CYAN}Step 3: Adding Trivy repository to the sources list...${RESET}"

echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Trivy repository added successfully.${RESET}"
else
    echo -e "${RED}Failed to add Trivy repository.${RESET}"
    exit 1
fi

# Step 4: Update package list
echo -e "${CYAN}Step 4: Updating package list...${RESET}"

sudo apt-get update -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Package list updated successfully.${RESET}"
else
    echo -e "${RED}Failed to update package list.${RESET}"
    exit 1
fi

# Step 5: Install Trivy
echo -e "${CYAN}Step 5: Installing Trivy...${RESET}"

sudo apt-get install trivy -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Trivy installed successfully.${RESET}"
else
    echo -e "${RED}Failed to install Trivy.${RESET}"
    exit 1
fi

# Final message
echo -e "${CYAN}Trivy installation is complete!${RESET}"
echo -e "${YELLOW}You can now run Trivy by typing 'trivy' in your terminal.${RESET}"

