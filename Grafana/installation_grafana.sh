#!/bin/bash

# Color variables for better readability in dark mode
RED='\033[0;31m'     # Red for errors or important messages
GREEN='\033[0;32m'   # Green for success
YELLOW='\033[1;33m'  # Yellow for warnings or non-critical info
CYAN='\033[0;36m'    # Cyan for general info
RESET='\033[0m'      # Reset color

# Step 1: Pull the Grafana Docker image
echo -e "${CYAN}Step 1: Pulling Grafana Docker image...${RESET}"

docker pull grafana/grafana
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Grafana Docker image pulled successfully.${RESET}"
else
    echo -e "${RED}Failed to pull Grafana Docker image.${RESET}"
    exit 1
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 2: Run the Grafana container
echo -e "${CYAN}Step 2: Running Grafana container...${RESET}"

docker run -d --name=grafana -p 3000:3000 grafana/grafana
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Grafana container is running successfully.${RESET}"
else
    echo -e "${RED}Failed to run Grafana container.${RESET}"
    exit 1
fi

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 3: Set up Grafana user credentials
echo -e "${CYAN}Step 3: Configuring Grafana default user credentials...${RESET}"

# Default user credentials
USER="admin"
PASSWORD="admin"

# You can add more user management options if needed
echo -e "${CYAN}Grafana default login credentials are:${RESET}"
echo -e "${GREEN}Username: $USER${RESET}"
echo -e "${GREEN}Password: $PASSWORD${RESET}"

# Gap for readability
echo -e "${YELLOW}---${RESET}"

# Step 4: Access Grafana
echo -e "${CYAN}Step 4: Access Grafana UI at http://localhost:3000${RESET}"

# Provide instructions to the user
echo -e "${YELLOW}Grafana has been successfully set up! You can access it at the following URL:${RESET}"
echo -e "${GREEN}http://localhost:3000${RESET}"

echo -e "${YELLOW}Log in with the default credentials:${RESET}"
echo -e "${GREEN}Username: admin${RESET}"
echo -e "${GREEN}Password: admin${RESET}"

# Final message
echo -e "${CYAN}Grafana installation complete!${RESET}"
echo -e "${YELLOW}You can now start configuring Grafana dashboards and data sources.${RESET}"

