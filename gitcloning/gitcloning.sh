#!/bin/bash

# Settings / Change This To Your Config
remoteHost=github.com
remoteSSH=git@$remoteHost
remoteUser=arshsahzad
remoteGroup=oodlestechnologies
localCodeDir="${HOME}/${USER}/devops/projects/BashScript/gitcloning/"

# Check RemoteHost Access via SSH
ssh $remoteSSH
echo ""

# Enter Repository Name
read -p "Enter Repository Name: " remoteRepo
mkdir -p $localCodeDir $remoteRepo && cd ./$remoteRepo
#echo ""
echo "Created Directory for ($remoteRepo)"

# Get Repo Branch Number
echo ''
read -p "No. of Branch to Clone for ($remoteRepo): " branchNum
while [ $branchNum -gt 0 ]
do

# Enter Branch Name
echo ""
read -p "Enter Branch Name of ($remoteRepo): " remoteBranch
mkdir -p ./$remoteBranch && cd ./$remoteBranch

# Cloning Repo of Particular Branch
echo ""
echo "===== Cloning Repository ($remoteRepo) of Branch ($remoteBranch) ====="
echo ""
git clone $remoteSSH:$remoteUser/$remoteRepo.git -b $remoteBranch
cd ..

# While Run Branch is = 0
branchNum=$(( $branchNum - 1 ))
done
