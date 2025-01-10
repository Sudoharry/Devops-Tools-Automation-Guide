#!/bin/bash

### Define the container name and image
CONTAINER_NAME="sonarqube"
IMAGE="sonarqube:lts-community"

### Color variables for better readability in dark mode
RED='\033[0;31m'     # Red for errors or important messages
GREEN='\033[0;32m'   # Green for success
YELLOW='\033[1;33m'  # Yellow for warnings or non-critical info
CYAN='\033[0;36m'    # Cyan for general info
RESET='\033[0m'      # Reset color

### Step 1: Check if the container is already running
echo -e "${CYAN}Checking if SonarQube container '$CONTAINER_NAME' is already running...${RESET}"
if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
    echo -e "${YELLOW}SonarQube container '$CONTAINER_NAME' is already running.${RESET}"
else
    ### Step 2: Run the SonarQube container with custom name and port mapping
    echo -e "${CYAN}Starting SonarQube container '$CONTAINER_NAME'...${RESET}"
    docker run -dit --name $CONTAINER_NAME -p 9000:9000 $IMAGE
    
    ### Step 3: Check if the container started successfully
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}SonarQube container '$CONTAINER_NAME' started successfully.${RESET}"
        echo -e "${CYAN}SonarQube is now running at http://0.0.0.0:9000 or http://localhost:9000.${RESET}"
    else
        echo -e "${RED}Failed to start SonarQube container '$CONTAINER_NAME'.${RESET}"
    fi
fi

