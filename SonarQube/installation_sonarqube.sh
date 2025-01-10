#!/bin/bash

# Define the container name and image
CONTAINER_NAME="sonarqube"
IMAGE="sonarqube:lts-community"

# Color variables for better readability in dark mode
RED='\033[0;31m'     # Red for errors or important messages
GREEN='\033[0;32m'   # Green for success
YELLOW='\033[1;33m'  # Yellow for warnings or non-critical info
CYAN='\033[0;36m'    # Cyan for general info
RESET='\033[0m'      # Reset color

# Step 1: Stop and remove the SonarQube container
if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
    echo -e "${CYAN}Stopping and removing SonarQube container...${RESET}"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
    echo -e "${GREEN}SonarQube container stopped and removed successfully.${RESET}"
else
    echo -e "${YELLOW}SonarQube container is not running.${RESET}"
fi

# Step 2: Remove the SonarQube Docker image
if [ $(docker images -q $IMAGE) ]; then
    echo -e "${CYAN}Removing SonarQube Docker image...${RESET}"
    docker rmi $IMAGE
    echo -e "${GREEN}SonarQube Docker image removed successfully.${RESET}"
else
    echo -e "${YELLOW}SonarQube Docker image not found.${RESET}"
fi

# Step 3: Clean up SonarQube logs and data direct

