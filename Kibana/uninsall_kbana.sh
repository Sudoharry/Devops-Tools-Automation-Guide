#!/bin/bash

# Define colors for readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Step-by-step guide
echo -e "${CYAN}###########################################${RESET}"
echo -e "${CYAN}#   Kibana Uninstallation Using Docker    #${RESET}"
echo -e "${CYAN}###########################################${RESET}\n"

# Step 1: Stop and remove the Kibana container
echo -e "${BLUE}Step 1: Stopping and removing the Kibana container...${RESET}"
CONTAINER_NAME="kibana"

if docker ps -a | grep -q $CONTAINER_NAME; then
    echo -e "${GREEN}Stopping Kibana container...${RESET}"
    docker stop $CONTAINER_NAME > /dev/null 2>&1

    echo -e "${GREEN}Removing Kibana container...${RESET}"
    docker rm $CONTAINER_NAME > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Kibana container removed successfully.${RESET}"
    else
        echo -e "${RED}Failed to remove Kibana container. Please check manually.${RESET}"
        exit 1
    fi
else
    echo -e "${RED}No Kibana container found. Skipping this step.${RESET}"
fi

echo -e ""

# Step 2: Remove the Kibana Docker image
echo -e "${BLUE}Step 2: Removing the Kibana Docker image...${RESET}"
KIBANA_TAG="8.5.0"  # Change this if a different version was used

if docker images | grep -q "kibana"; then
    docker rmi kibana:$KIBANA_TAG > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Kibana Docker image removed successfully.${RESET}"
    else
        echo -e "${RED}Failed to remove Kibana Docker image. Please check manually.${RESET}"
        exit 1
    fi
else
    echo -e "${RED}No Kibana Docker image found. Skipping this step.${RESET}"
fi

echo -e ""

# Step 3: Check for Docker network
echo -e "${BLUE}Step 3: Removing the Docker network (optional)...${RESET}"
NETWORK_NAME="somenetwork"

if docker network ls | grep -q $NETWORK_NAME; then
    echo -e "${GREEN}Removing Docker network '${NETWORK_NAME}'...${RESET}"
    docker network rm $NETWORK_NAME > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Docker network '${NETWORK_NAME}' removed successfully.${RESET}"
    else
        echo -e "${RED}Failed to remove Docker network '${NETWORK_NAME}'. Please check manually.${RESET}"
        exit 1
    fi
else
    echo -e "${RED}No Docker network '${NETWORK_NAME}' found. Skipping this step.${RESET}"
fi

echo -e ""

# Final message
echo -e "${CYAN}###########################################${RESET}"
echo -e "${CYAN}#    Kibana Uninstallation Completed      #${RESET}"
echo -e "${CYAN}###########################################${RESET}\n"

