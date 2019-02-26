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

echo "${RED}TEST${NC}"

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
echo "${NC}${YELLOW}"
echo "Are You Ready For The [ SINGULARITY? ]"
echo "${NC}${RED}"
echo "[ WARNING ]"
echo
echo "Before moving ahead with the installation you must ensure that OSX is fully updated"
echo "and Xcode developer tools are fully installed and updated."
echo
echo "${NC}${YELLOW}"
echo "--------------------------------------------------------------------------------------"
read -p "${NC}${GREEN} [ Are you sure OSX is fully updated? ]" answer
read -p "${NC}${GREEN} [ Are you sure Xcode is fully installed? ]" answer
clear
sleep 1s
echo "[ INITIATING SINGULARITY...]"
sleep 2s
clear

#[ Force Software Update on Mac ]
echo "${NC}${YELLOW}[ Checking for OSX Software Updates just in case...] ${NC}"
echo
sudo softwareupdate -iva
sleep 1s
clear

#[ Install XCode ]
echo
echo "${YELLOW}[ Installing XCode command line tools for Mac...]${NC}"
xcode-select --install
clear

#[ Install Brew for Mac ]
echo
echo "${YELLOW}[ INSTALLING BREW...]${NC}"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
clear

#[ Install Git ]
echo
echo "${YELLOW}[ INSTALLING GIT ]${NC}"
brew install git

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
echo
echo "${GREEN}Adding RSA Keys to Github Account...${NC}"

#Copy key to Clipboard
pbcopy < ~/.ssh/id_rsa.pub
clear
cat ~/.ssh/id_rsa.pub
echo
echo "${YELLO}Your Public SSH Key is Now Loaded In Your ${GREEN}CLIPBOARD (ctrl/cmd+v)${NC}"
echo
echo "${YELLOW} Please visit https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/"
echo "For instructions on how to add it to your GitHub Account."
echo
sleep 2s
read -p "${GREEN}Ready To Proceed?${NC}"

brew install htop curl npm virtualbox

# [ Install NODE ]
clear
echo
echo "${YELLOW}[ INSTALLING NODE.JS...]${NC}"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
nvm install node 8.11.1
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
brew install libpng-dev mozjpeg

#[ Install Libtool, automake, nams and autoconf ]
clear
echo
echo "${YELLOW} [ Fixing MOZJPEG ]${NC}"
brew install libtool automake autoconf nasm


clear
echo
echo "${GREEN}[ INSTALLATION COMPLETE]${NC}"
