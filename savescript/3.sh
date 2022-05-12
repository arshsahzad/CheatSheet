#!/bin/bash
#
#This script is intended to be used with repositories that need authentication
#

#Funtion to erase the $username:$password@ from the config file from git in the repo
function erase_user_pass() {
  printf "${green}lets clean $1 from $2 \n${normal}"
  sed -i 's/'"$1"'/'""'/g' $2
}

#function to download the repo
#1-clone the repo
#2-fix the config file by deleting the user and password
#3-execute the git command to automatically store the credentials if the user answer yes on the startup
#
# param 1 = name of the repo
# param 2 = string to complet the url of the repo
#
# example repo in https://git.something.com/yourcompany/your.project.git
#
# the param1 should be your.project
# the param2 should be git.something.com/yourcompany/your.project.git (without 'https://')
#
# download_repo 'your.project' 'git.something.com/yourcompany/your.project.git'
#
function download_repo() {
  path=$(pwd)
  printf "${blue}\n Importing $1\n\n${normal}"
  git clone https://$username:$password@$2
  file="$(pwd)/$1/.git/config"
  replace_string="$username:$password@"
  erase_user_pass $replace_string $file
  cd ./$1
  if [ "$STORE_OK" == 'Yes' ]
    then
     printf "${green} store credentials for the repo $1  \n${normal}"
     git config credential.helper store
  fi
  cd $path
}

blue=$(tput setaf 4)
green=$(tput setaf 2)
normal=$(tput sgr0)

echo -n Please Enter your GitHub Username:
read username
echo -n Please Enter your GitHub Password:
read -s password

printf "\n\nDo you want to store your credentials locally?:"
STORE_OK=
select STORE_OK in Yes No
do
  case $STORE_OK in
    '') echo 'Please enter 1 for Yes, or 2 for No.';;
    ?*) break
  esac
done

printf "${blue}\n\n lets import your repos\n\n${normal}"

# repo 1 https://git.something.com/yourcompany/your.project.git
download_repo 'your.project' 'git.something.com/yourcompany/your.project.git'
# repo 2 https://git.something.com/yourcompany/your.project2.git
download_repo 'your.project2' 'git.something.com/yourcompany/your.project2.git'

printf "${blue}\n Enjoy :)"

exit 0