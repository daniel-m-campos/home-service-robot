#!/bin/bash
C='\033[0;36m'
NC='\033[0m'
# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line
echo -e "${C}Obtaining a copy of kitware's signing key${NC}"
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null \
 | gpg --dearmor - \
 | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg \
 >/dev/null

echo -e "${C}Add kitware's repository to your sources list. Assuming
Xenial${NC}"

sudo apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ xenial main'
sudo apt update -y

echo -e "${C}Installing kitware-archive-keyring${NC}"
sudo apt install -y kitware-archive-keyring
sudo rm /etc/apt/trusted.gpg.d/kitware.gpg

echo -e "${C}Upgrading CMake${NC}"
sudo apt update -y
sudo apt install -y cmake