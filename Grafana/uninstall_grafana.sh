#!/bin/bash

# Color variables for better readability in dark mode
RED='\033[0;31m'     # Red for errors or important messages
GREEN='\033[0;32m'   # Green for success
YELLOW='\033[1;33m'  # Yellow for warnings or non-critical info
CYAN='\033[0;36m'    # Cyan for general info
RESET='\033[0m'      # Reset color

# Step 1: Stop and remove the Grafana container
echo -e "${CYAN}Step 1: Stopping and removing Grafana container...${RESET}"

docker stop grafana
docker rm grafana
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Grafana container stopped and removed successfully.${RESET}"
else
    echo -e "${RED}Failed to stop or remove Grafana container.${RESET}"
    exit 1
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 2: Remove the Grafana Docker image
echo -e "${CYAN}Step 2: Removing Grafana Docker image...${RESET}"

docker rmi grafana/grafana
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Grafana Docker image removed successfully.${RESET}"
else
    echo -e "${RED}Failed to remove Grafana Docker image.${RESET}"
    exit 1
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 3: Clean up Docker volumes and networks (if any created)
echo -e "${CYAN}Step 3: Cleaning up any remaining Docker volumes and networks...${RESET}"

docker volume prune -f
docker network prune -f
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Docker volumes and networks cleaned up successfully.${RESET}"
else
    echo -e "${RED}Failed to clean up Docker volumes and networks.${RESET}"
    exit 1
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Final message
echo -e "${CYAN}Grafana uninstallation complete!${RESET}"
echo -e "${YELLOW}Grafana and all associated files have been removed from your system.${RESET}"

