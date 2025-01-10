#!/bin/bash

# Define colors for readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to install MySQL
install_mysql() {
    echo -e "${GREEN}Starting MySQL installation...${NC}"

    # Update system package
    echo -e "${YELLOW}Updating system packages...${NC}"
    sudo apt update || { echo -e "${RED}Failed to update system packages.${NC}"; exit 1; }

    # Install MySQL server
    echo -e "${YELLOW}Installing MySQL server...${NC}"
    sudo apt install mysql-server -y || { echo -e "${RED}Failed to install MySQL server.${NC}"; exit 1; }

    # Start MySQL server
    echo -e "${YELLOW}Starting MySQL service...${NC}"
    sudo systemctl start mysql.service || { echo -e "${RED}Failed to start MySQL service.${NC}"; exit 1; }

    # Enable MySQL service
    echo -e "${YELLOW}Enabling MySQL service...${NC}"
    sudo systemctl enable mysql.service || { echo -e "${RED}Failed to enable MySQL service.${NC}"; exit 1; }

    echo -e "${GREEN}MySQL installation and setup completed successfully.${NC}"
}

# Main execution
install_mysql
