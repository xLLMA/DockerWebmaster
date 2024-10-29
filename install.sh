#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

clear
echo -e "${GREEN}"
echo ""
echo "======================================================================="
echo "|                                                                     |"
echo "|     full-stack-nginx-wordpress-for-everyone-with-docker-compose     |"
echo "|                      by Mmdrza.Com                                  |"
echo "|                                                                     |"
echo "======================================================================="
echo -e "${NC}"
sleep 2

# Prompt for installation type
echo -e "${GREEN}Please select the installation option:${NC}"
echo "1) Docker + Nginx + Portainer + WordPress"
echo "2) Docker + Nginx + Portainer"
read -p "Enter your choice (1 or 2): " choice

# Validate user input
while [[ "$choice" != "1" && "$choice" != "2" ]]; do
    echo -e "${RED}Invalid choice. Please enter 1 or 2.${NC}"
    read -p "Enter your choice (1 or 2): " choice
done

# Package Management System Detection
lpms=""
for i in apk dnf yum apt zypper; do
    if [ -x "$(command -v $i)" ]; then
        lpms=$i
        break
    fi
done

if [ -z $lpms ]; then
    echo -e "${RED}Could not detect package management system.${NC}"
    exit 0
fi

# Uninstall old versions if any
echo -e "${GREEN}Uninstalling old versions of Docker...${NC}"
if [ "$lpms" == "apk" ]; then
    sudo apk del docker podman-docker
elif [ "$lpms" == "dnf" ]; then
    sudo dnf remove docker docker-client docker-common docker-latest docker-engine
elif [ "$lpms" == "yum" ]; then
    sudo yum remove docker docker-client docker-common docker-latest docker-engine
elif [ "$lpms" == "apt" ]; then
    sudo apt remove docker docker-engine docker.io
elif [ "$lpms" == "zypper" ]; then
    sudo zypper remove docker docker-client
fi

echo -e "${GREEN}Docker uninstalled successfully.${NC}"

# Install Docker
echo -e "${GREEN}Installing Docker...${NC}"
if [ "$lpms" == "apk" ]; then
    sudo apk add --update docker openrc
    sudo rc-update add docker boot
    sudo service docker start
elif [ "$lpms" == "dnf" ]; then
    sudo dnf install docker
elif [ "$lpms" == "yum" ]; then
    sudo yum install docker
elif [ "$lpms" == "apt" ]; then
    sudo apt update
    sudo apt install docker-ce docker-ce-cli
elif [ "$lpms" == "zypper" ]; then
    sudo zypper install docker
fi

echo -e "${GREEN}Docker installed successfully.${NC}"

# Run Docker without sudo rights
echo -e "${GREEN}Configuring Docker to run without sudo...${NC}"
sudo groupadd docker
sudo usermod -aG docker ${USER}

# Install Docker Compose
echo -e "${GREEN}Installing Docker Compose...${NC}"
sudo curl -SL "https://github.com/docker/compose/releases/download/v2.27.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Final setup based on user choice
if [ "$choice" == "1" ]; then
    # Code to install WordPress, Nginx, and Portainer goes here
    echo -e "${GREEN}Installing Docker + Nginx + Portainer + WordPress...${NC}"
    # Example of additional installation commands
elif [ "$choice" == "2" ]; then
    # Code to install only Nginx and Portainer goes here
    echo -e "${GREEN}Installing Docker + Nginx + Portainer...${NC}"
    # Example of additional installation commands
fi

# Finish
echo -e "${GREEN}Setup completed!${NC}"
