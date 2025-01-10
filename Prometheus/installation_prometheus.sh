#!/bin/bash

# Color variables for better readability in dark mode
RED='\033[0;31m'     # Red for errors or important messages
GREEN='\033[0;32m'   # Green for success
YELLOW='\033[1;33m'  # Yellow for warnings or non-critical info
CYAN='\033[0;36m'    # Cyan for general info
RESET='\033[0m'      # Reset color

# Step 1: Pull the Prometheus Docker image
echo -e "${CYAN}Step 1: Pulling the Prometheus Docker image...${RESET}"

docker pull ubuntu/prometheus:2.53.3-24.04_stable
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Prometheus Docker image pulled successfully.${RESET}"
else
    echo -e "${RED}Failed to pull Prometheus Docker image.${RESET}"
    exit 1
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 2: Run the Prometheus container
echo -e "${CYAN}Step 2: Starting Prometheus container...${RESET}"

docker run -d --name prometheus-container -e TZ=UTC -p 9090:9090 ubuntu/prometheus:2.53.3-24.04_stable
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Prometheus container started successfully.${RESET}"
else
    echo -e "${RED}Failed to start Prometheus container.${RESET}"
    exit 1
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 3: Verify Prometheus is running
echo -e "${CYAN}Step 3: Verifying that Prometheus is running...${RESET}"

docker ps | grep prometheus-container
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Prometheus container is running.${RESET}"
else
    echo -e "${RED}Prometheus container is not running. Please check the logs using 'docker logs prometheus-container'.${RESET}"
    exit 1
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 4: Provide user instructions
echo -e "${CYAN}Step 4: Accessing Prometheus...${RESET}"

echo -e "${YELLOW}Prometheus is now running on port 9090. You can access the Prometheus web interface by opening the following URL in your web browser:${RESET}"
echo -e "${CYAN}http://localhost:9090${RESET}"

# Final message
echo -e "${CYAN}Prometheus installation is complete!${RESET}"
echo -e "${YELLOW}Use 'docker stop prometheus-container' to stop the container or 'docker rm prometheus-container' to remove it.${RESET}"

