#!/usr/bin/env bash
clear
# [ Black Mesa - Vue.js Dependencies ]
# ------------------------------------------------------------------
# Lucas Moreira - l.moreira@live.ca
# ------------------------------------------------------------------
#
# Setup Bash Script for installing Node dependencies and running dev server
# with support for Windows | Mac | Linux architectures.

# Program Variables
BLACKMESA="[ Singularity Manager ] ||"

# Error Handling Function
error_handle() {
echo
echo "${RED}[ ERROR ] || ${BLACKMESA}: $1${NC}"
echo
exit 1
}

# Color Variables
ORANGE=`tput setaf 5`
GREEN=`tput setaf 2`
RED=`tput setaf 1`
YELLOW=`tput setaf 3`
NC=`tput sgr0`

# [ Output Art & Introduction ] ------------------------------------
clear
echo "${YELLOW}"
#Show ASCII Art if it's there.
if [ -f ./kryptonite.txt ]
then
  cat ./kryptonite.txt
fi
echo
sleep 2s
echo "======================================================================================"
echo "${NC}${RED}"
echo "Are You Ready For The [ SINGULARITY? ]"
echo "${NC}${YELLOW}"
echo "--------------------------------------------------------------------------------------"
read -p "${NC}${GREEN} [ YES JOIN THE SINGULARITY | YES JOIN THE SINGULARITY ]" answer
clear
echo "[ GENERATING BIO IMPLANTS... ]"
sleep 1s
echo "[ PROCURING NETWORK CONNECTIONS... ]"
sleep 1s
echo "[ INITIATING SINGULARITY...]"
sleep 2s
clear

#[ UPDATE APT-GET]
echo "${NC}${YELLOW} [ Updating Data Repository - Prepare SUDO ]${NC}"

if sudo apt-get update
then
  clear
  echo "${GREEN}[ DATA REPOSITORY SUCCESSFULLY UPDATED ]${NC}"
else
  error_handle "SUDO Failed to update Apt-Get...you are not ready for the singularity."
fi
# [ Check for GIT installation & Configuration ]
if git --version
then
    clear
    echo
    echo "${GREEN}Git is installed... Moving on to Git Configuration${NC}"
    sleep 5s
  else
    # Install Git on LInux
    sudo apt-get install git
fi

# [ CONFIGURE GIT ]
if git config --global user.name
then
  # Git Config Already done.
  clear
  echo
  echo "${GREEN}Git global parameters already configured. Proceeding.${NC}"
  sleep 5s
else
  echo "${YELLOW}Configuring Git Base Parameters.${NC}"
  echo
  sleep 2s
  # Configure --global user.name
  read -p "${GREEN}Please enter your --global user.name...${NC}  " username
  git config --global user.name $username
  sleep 2s
  # Configure --global user.email
  echo
  read -p "${GREEN}Please enter your --global user.email...${NC}  " useremail
  git config --global user.email $useremail
  echo
  echo "${GREEN}Finished Configuring Git. Proceeding.${NC}"
fi

sleep 2s
clear
echo
echo "${GREEN}Setting Up SSH Keys${NC}"
echo
sleep 3s

# [ GET RSA KEYS SETUP ]
if ls -al ~/.ssh/id_rsa.pub
then
  # ID Setup Moving On
  clear
  echo
  echo "${GREEN}Public Key Already Generated... Proceeding.${NC}"
  sleep 2s
else
  # Generate ID
  clear
  echo
  echo "${GREEN}Generating RSA Key Pairs..."
  echo
  sleep 2s
  # Generate SSH Key
  read -p "${YELLOW}Please Enter the Same Email Used For user.email...${NC}" useremailrsa
  ssh-keygen -t rsa -b 4096 -C $useremailrsa
  sleep 1s
  # Add to SSH Agent
  echo
  echo "${GREEN}Adding Key to SSH Agent...${NC}"
  sleep 2s
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa
  sleep 2s
fi

clear


clear
echo
echo "${YELLOW}[ Installing XClip.... ]${NC}"
sleep 1s
# Install XClip
sudo apt-get install xclip
# Copy RSA to Clipboard
echo
echo "${GREEN}Copying RSA Key To Clipboard...${NC}"
sleep 2s
xclip -sel clip < ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub
echo
echo "${YELLO}Your Public SSH Key is Now Loaded In Your ${GREEN}CLIPBOARD (ctrl/cmd+v)${NC}"
echo
echo "${YELLOW} Please visit https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/"
echo "For instructions on how to add it to your GitHub Account."
sleep 2s
echo
read -p "${GREEN}Ready To Proceed?${NC}"

clear
echo
echo "${YELLOW}[ Installing Necessary Build Tools & Dependencies ]${NC}"
echo
# Install Build Essentials and Libssl
sudo apt-get install build-essential libssl-dev
clear
echo
# Install LibPCRE3
sudo apt-get install libpcre3 libpcre3-dev libpcrecpp0v5
clear
echo
# install zlib
sudo apt-get install zlib1g-dev
clear
echo
# Install Process manager htop
sudo apt-get install htop curl virtualbox
clear
echo
sudo apt-get install npm
# [[ NODE JS ]].
if node -v
  then
    echo
    echo "${GREEN}Node is already installed. Proceeding with Dependencies...${NC}"
    sleep 5s
  else
    clear
    echo
    echo "${RED}Node installation is missing.${NC}"
    echo
    echo "${GREEN}Preparing to Install Node..."
    sleep 3s

    # Linux Node Install Script
    clear
    echo
    echo "${YELLOW}[ Operating System Detected as: ${GREEN}Linux / GNU${NC}${YELLOW}]${NC}"
    sleep 2s
    # Prepare Install
    sudo apt-get update
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
    nvm install node lts
fi

#[ Install VUE Globally ]
clear
echo
echo "{$YELLOW}[ INSTALLING VUE.js Globally ]${NC}"
npm install -g vue
npm install -g vue-cli

#[ Install Libpng for pngquant ]
clear
echo
echo "${YELLOW}[ INSTALLING LIBPNG ]${NC}"
sudo apt-get install libpng-dev mozjpeg

#[ Install Libtool, automake, nams and autoconf ]
clear
echo
echo "${YELLOW} [ Fixing MOZJPEG ]${NC}"
sudo apt-get install libtool automake autoconf nasm

#[ENDING]
clear
echo "${YELLOW}"
#Show ASCII Art if it's there.
sleep 2s
echo "======================================================================================"
echo
echo "[ SINGULARITY ACHIEVED ]"
echo
echo "List Of Installed Apps:"
echo
echo "- Git"
echo "- Xclip"
echo "- Vim"
echo "- Vundle (With Plugins)"
echo "- OhMyZSH"
echo "- Tree"
echo "- HTOP"
echo "- TaskWarrior"
echo "- Guake"
echo
echo "======================================================================================"
sleep 5s
exit 1
