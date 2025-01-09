#!/bin/bash

# Jenkins Uninstallation Script

# Color codes for formatting
BLUE="\033[1;34m"
GREEN="\033[1;32m"
RED="\033[1;31m"
RESET="\033[0m"

echo -e "${BLUE}## Step 1: Stopping Jenkins service... ##${RESET}"
sudo systemctl stop jenkins

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Jenkins service stopped successfully.${RESET}"
else
  echo -e "${RED}Failed to stop Jenkins service. Please check if it is running.${RESET}"
fi

echo -e "${BLUE}## Step 2: Uninstalling Jenkins package... ##${RESET}"
sudo apt-get remove --purge -y jenkins

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Jenkins package removed successfully.${RESET}"
else
  echo -e "${RED}Failed to remove Jenkins package.${RESET}"
fi

echo -e "${BLUE}## Step 3: Removing Jenkins repository key and list file... ##${RESET}"
sudo rm -f /usr/share/keyrings/jenkins-keyring.asc
sudo rm -f /etc/apt/sources.list.d/jenkins.list

echo -e "${GREEN}Jenkins repository key and list file removed.${RESET}"

echo -e "${BLUE}## Step 4: Deleting Jenkins logs and configuration files... ##${RESET}"
sudo rm -rf /var/lib/jenkins
sudo rm -rf /var/log/jenkins
sudo rm -rf /etc/default/jenkins
sudo rm -rf /etc/jenkins

echo -e "${GREEN}Jenkins logs and configuration files deleted.${RESET}"

echo -e "${BLUE}## Step 5: Cleaning up unused dependencies... ##${RESET}"
sudo apt-get autoremove -y
sudo apt-get autoclean

echo -e "${GREEN}Unused dependencies cleaned.${RESET}"

echo -e "${GREEN}## Jenkins uninstallation complete! ##${RESET}"
