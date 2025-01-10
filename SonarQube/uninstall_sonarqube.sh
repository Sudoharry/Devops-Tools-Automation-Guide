#!/bin/bash

# Define the container name and image
CONTAINER_NAME="sonarqube"
IMAGE="sonarqube:lts-community"

# Color variables for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Step 1: Check if the SonarQube container is running
echo -e "${BLUE}Step 1: Checking if SonarQube container is running...${RESET}"

if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
    echo -e "${GREEN}SonarQube container is running. Stopping and removing the container...${RESET}"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
    echo -e "${GREEN}SonarQube container stopped and removed successfully.${RESET}"
else
    echo -e "${YELLOW}SonarQube container is not running.${RESET}"
fi

# Step 2: Remove the SonarQube Docker image
echo -e "${BLUE}Step 2: Removing SonarQube Docker image...${RESET}"

if [ $(docker images -q $IMAGE) ]; then
    echo -e "${GREEN}SonarQube Docker image found. Removing the image...${RESET}"
    docker rmi $IMAGE
    echo -e "${GREEN}SonarQube Docker image removed successfully.${RESET}"
else
    echo -e "${YELLOW}SonarQube Docker image not found.${RESET}"
fi

# Step 3: Clean up logs and data directories (if applicable)
echo -e "${BLUE}Step 3: Cleaning up SonarQube logs and data directories...${RESET}"

LOGS_DIR="/var/log/sonarqube"
DATA_DIR="/var/opt/sonarqube"

if [ -d "$LOGS_DIR" ]; then
    echo -e "${GREEN}SonarQube logs directory found. Cleaning up logs...${RESET}"
    rm -rf $LOGS_DIR
    echo -e "${GREEN}SonarQube logs cleaned up successfully.${RESET}"
else
    echo -e "${YELLOW}SonarQube logs directory not found.${RESET}"
fi

if [ -d "$DATA_DIR" ]; then
    echo -e "${GREEN}SonarQube data directory found. Cleaning up data...${RESET}"
    rm -rf $DATA_DIR
    echo -e "${GREEN}SonarQube data cleaned up successfully.${RESET}"
else
    echo -e "${YELLOW}SonarQube data directory not found.${RESET}"
fi

# Final message
echo -e "${BLUE}SonarQube uninstallation complete.${RESET}"

