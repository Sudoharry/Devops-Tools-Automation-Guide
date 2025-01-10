#!/bin/bash

# Color variables for better readability in dark mode
RED='\033[0;31m'     # Red for errors or important messages
GREEN='\033[0;32m'   # Green for success
YELLOW='\033[1;33m'  # Yellow for warnings or non-critical info
CYAN='\033[0;36m'    # Cyan for general info
RESET='\033[0m'      # Reset color

# Step 1: Remove the Trivy package
echo -e "${CYAN}Step 1: Removing Trivy package...${RESET}"

sudo apt-get remove --purge trivy -y
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Trivy package removed successfully.${RESET}"
else
    echo -e "${RED}Failed to remove Trivy package.${RESET}"
    exit 1
fi

# Step 2: Remove the Trivy repository from sources list
echo -e "${CYAN}Step 2: Removing Trivy repository from the sources list...${RESET}"

sudo rm -f /etc/apt/sources.list.d/trivy.list
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Trivy repository removed successfully.${RESET}"
else
    echo -e "${RED}Failed to remove Trivy repository.${RESET}"
    exit 1
fi

# Step 3: Remove the Trivy GPG key
echo -e "${CYAN}Step 3: Removing Trivy GPG key...${RESET}"

sudo apt-key del $(sudo apt-key list | grep -B 1 "Trivy" | head -n 1 | awk '{print $2}')
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Trivy GPG key removed successfully.${RESET}"
else
    echo -e "${RED}Failed to remove Trivy GPG key.${RESET}"
    exit 1
fi

# Step 4: Clean up remaining dependencies and cache
echo -e "${CYAN}Step 4: Cleaning up dependencies and cache...${RESET}"

sudo apt-get autoremove -y
sudo apt-get clean
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Clean up completed successfully.${RESET}"
else
    echo -e "${RED}Failed to clean up dependencies and cache.${RESET}"
    exit 1
fi

# Final message
echo -e "${CYAN}Trivy uninstallation is complete!${RESET}"
echo -e "${YELLOW}Trivy has been successfully removed from your system.${RESET}"

