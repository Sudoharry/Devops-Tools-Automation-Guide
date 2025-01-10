#!/bin/bash

# Jenkins Installation Script

# Color codes for formatting
BLUE="\033[1;34m"
GREEN="\033[1;32m"
RESET="\033[0m"

echo -e "${BLUE}## Step 1: Updating the package list... ##${RESET}"
sudo apt update

echo -e "${BLUE}## Step 2: Installing Java (OpenJDK 17)... ##${RESET}"
sudo apt install -y fontconfig openjdk-17-jre

echo -e "${BLUE}## Step 3: Verifying Java installation... ##${RESET}"
java -version
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Java installed successfully.${RESET}"
else
  echo -e "${RED}Java installation failed. Exiting.${RESET}"
  exit 1
fi

echo -e "${BLUE}## Step 4: Adding the Jenkins repository key... ##${RESET}"
sudo wget -q -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo -e "${BLUE}## Step 5: Adding the Jenkins repository... ##${RESET}"
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo -e "${BLUE}## Step 6: Updating the package list... ##${RESET}"
sudo apt-get update

echo -e "${BLUE}## Step 7: Installing Jenkins... ##${RESET}"
sudo apt-get install -y jenkins

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Jenkins installed successfully.${RESET}"
else
  echo -e "${RED}Jenkins installation failed. Exiting.${RESET}"
  exit 1
fi

echo -e "${GREEN}## Jenkins installation complete! ##${RESET}"
echo -e "${BLUE}You can now start Jenkins using: sudo systemctl start jenkins${RESET}"
echo -e "${BLUE}Access Jenkins in your browser at: http://<your-server-ip>:8080${RESET}"
