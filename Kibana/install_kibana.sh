#!/bin/bash

# Define colors for readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Step-by-step guide
echo -e "${CYAN}###########################################${RESET}"
echo -e "${CYAN}#   Kibana Installation Using Docker      #${RESET}"
echo -e "${CYAN}###########################################${RESET}\n"

# Step 1: Create a Docker network if not exists
echo -e "${BLUE}Step 1: Checking Docker network...${RESET}"
NETWORK_NAME="somenetwork"

if ! docker network ls | grep -q $NETWORK_NAME; then
    echo -e "${GREEN}Creating Docker network '${NETWORK_NAME}'...${RESET}"
    docker network create $NETWORK_NAME
else
    echo -e "${GREEN}Network '${NETWORK_NAME}' already exists.${RESET}"
fi

echo -e ""

# Step 2: Pull the Kibana Docker image
echo -e "${BLUE}Step 2: Pulling Kibana Docker image...${RESET}"
KIBANA_TAG="8.5.0"  # Change this to your desired version

docker pull kibana:$KIBANA_TAG

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Kibana Docker image pulled successfully.${RESET}"
else
    echo -e "${RED}Failed to pull Kibana Docker image. Exiting.${RESET}"
    exit 1
fi

echo -e ""

# Step 3: Run the Kibana container
echo -e "${BLUE}Step 3: Running Kibana container...${RESET}"

CONTAINER_NAME="kibana"

docker run -d --name $CONTAINER_NAME --net $NETWORK_NAME -p 5601:5601 kibana:$KIBANA_TAG

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Kibana container is running successfully.${RESET}"
else
    echo -e "${RED}Failed to start Kibana container. Exiting.${RESET}"
    exit 1
fi

echo -e ""

# Step 4: Provide access information
echo -e "${BLUE}Step 4: Access Kibana Dashboard${RESET}"
echo -e "${GREEN}Kibana is now running. You can access it at:${RESET}"
echo -e "${CYAN}http://localhost:5601${RESET}\n"

# Final message
echo -e "${CYAN}###########################################${RESET}"
echo -e "${CYAN}#   Installation Completed Successfully   #${RESET}"
echo -e "${CYAN}###########################################${RESET}\n"

