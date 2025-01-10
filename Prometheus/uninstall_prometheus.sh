#!/bin/bash

# Color variables for better readability in dark mode
RED='\033[0;31m'     # Red for errors or important messages
GREEN='\033[0;32m'   # Green for success
YELLOW='\033[1;33m'  # Yellow for warnings or non-critical info
CYAN='\033[0;36m'    # Cyan for general info
RESET='\033[0m'      # Reset color

# Step 1: Stop the Prometheus container
echo -e "${CYAN}Step 1: Stopping the Prometheus container...${RESET}"

docker stop prometheus-container
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Prometheus container stopped successfully.${RESET}"
else
    echo -e "${YELLOW}Prometheus container was not running or could not be stopped.${RESET}"
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 2: Remove the Prometheus container
echo -e "${CYAN}Step 2: Removing the Prometheus container...${RESET}"

docker rm prometheus-container
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Prometheus container removed successfully.${RESET}"
else
    echo -e "${YELLOW}Prometheus container was not found or could not be removed.${RESET}"
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 3: Remove the Prometheus Docker image
echo -e "${CYAN}Step 3: Removing the Prometheus Docker image...${RESET}"

docker rmi ubuntu/prometheus:2.53.3-24.04_stable
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Prometheus Docker image removed successfully.${RESET}"
else
    echo -e "${YELLOW}Prometheus Docker image was not found or could not be removed.${RESET}"
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 4: Check for any leftover resources
echo -e "${CYAN}Step 4: Checking for leftover resources (logs, configurations, etc.)...${RESET}"

PROMETHEUS_DIR="/path/to/prometheus/data-or-config"
if [ -d "$PROMETHEUS_DIR" ]; then
    echo -e "${YELLOW}Prometheus data or configuration directory found at $PROMETHEUS_DIR.${RESET}"
    echo -e "${CYAN}Cleaning up leftover files...${RESET}"
    rm -rf "$PROMETHEUS_DIR"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Leftover files cleaned up successfully.${RESET}"
    else
        echo -e "${RED}Failed to clean up leftover files. Please check permissions.${RESET}"
    fi
else
    echo -e "${GREEN}No leftover Prometheus data or configuration files found.${RESET}"
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Final message
echo -e "${CYAN}Prometheus uninstallation is complete!${RESET}"
echo -e "${YELLOW}If you encounter any issues, ensure that all containers, images, and files related to Prometheus are removed manually.${RESET}"

