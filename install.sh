#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color (RESET)

clear
echo -e "${GREEN}"
echo ""
echo "======================================================================="
echo "|                                                                     |"
echo "|                     DOCKER WEBMASTER                                |"
echo "|                      by Mmdrza.Com                                  |"
echo "|                                                                     |"
echo "======================================================================="
echo -e "${NC}"
sleep 2

# Prompt for installation type
mkdir -p ~/docker/portainer/portainer_data
cd ~/docker/portainer
cp ~/docker/portainer/docker_compose_portainer_ce.yml ~/docker/portainer/docker-compose.yml
docker-compose up -d
rm docker_compose_portainer_ce.yml
rm install_portainer.sh
docker ps
# Finish
echo -e "${GREEN}Setup completed!${NC}"
