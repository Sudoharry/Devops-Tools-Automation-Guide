#!/bin/bash

# Define colors for readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to uninstall MySQL
uninstall_mysql() {
    echo -e "${GREEN}Starting MySQL uninstallation...${NC}"

    # Stop MySQL service
    echo -e "${YELLOW}Stopping MySQL service...${NC}"
    sudo systemctl stop mysql.service || { echo -e "${RED}Failed to stop MySQL service.${NC}"; exit 1; }

    # Remove MySQL server
    echo -e "${YELLOW}Removing MySQL server and related packages...${NC}"
    sudo apt purge mysql-server mysql-common mysql-client -y || { echo -e "${RED}Failed to remove MySQL server.${NC}"; exit 1; }

    # Clean up residual files
    echo -e "${YELLOW}Cleaning up residual MySQL files...${NC}"
    sudo apt autoremove -y || { echo -e "${RED}Failed to clean up residual files.${NC}"; exit 1; }
    sudo apt autoclean || { echo -e "${RED}Failed to autoclean.${NC}"; exit 1; }

    # Remove MySQL data directory
    echo -e "${YELLOW}Removing MySQL data directory...${NC}"
    sudo rm -rf /var/lib/mysql || { echo -e "${RED}Failed to remove MySQL data directory.${NC}"; exit 1; }
    sudo rm -rf /etc/mysql || { echo -e "${RED}Failed to remove MySQL configuration files.${NC}"; exit 1; }

    echo -e "${GREEN}MySQL uninstallation completed successfully.${NC}"
}

# Main execution
uninstall_mysql

