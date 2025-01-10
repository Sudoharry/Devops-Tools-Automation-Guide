#!/bin/bash

# Define color variables
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'  # No Color

# Function to uninstall and clean a package
clean_uninstall() {
    PACKAGE=$1
    echo -e "${YELLOW}Uninstalling $PACKAGE...${NC}"

    # Uninstall the package
    sudo apt remove --purge -y "$PACKAGE" || { echo -e "${RED}Failed to remove $PACKAGE${NC}"; exit 1; }

    # Clean up residual configuration files
    echo -e "${YELLOW}Cleaning up residual configuration files for $PACKAGE...${NC}"
    sudo apt autoremove -y || { echo -e "${RED}Failed to clean residual files${NC}"; exit 1; }
    sudo apt autoclean -y || { echo -e "${RED}Failed to clean package cache${NC}"; exit 1; }

    # Check for binary file leftovers and remove if found
    BINARY_PATH=$(which "$PACKAGE" 2>/dev/null)
    if [[ -n "$BINARY_PATH" && -e "$BINARY_PATH" ]]; then
        echo -e "${YELLOW}Removing leftover binary at $BINARY_PATH...${NC}"
        sudo rm -f "$BINARY_PATH" || { echo -e "${RED}Failed to remove $PACKAGE binary${NC}"; exit 1; }
    fi

    echo -e "${GREEN}$PACKAGE uninstallation and cleanup completed successfully.${NC}"
}

# Ensure a package name is provided
if [[ $# -eq 0 ]]; then
    echo -e "${RED}Usage: $0 <package-name>${NC}"
    exit 1
fi

# Main execution
clean_uninstall "$1"

