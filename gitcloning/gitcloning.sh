#!/bin/bash

#Enter Repository Name
read -p "Enter Repository Name: " repo_name
mkdir -p ./$repo_name && cd ./$repo_name
echo "Created Directory for $repo_name"

#Get Repo Branch Count
read -p "No. of Branch to Clone for $repo_name: " branch_count
while [ $branch_count -gt 0 ]
do

#Enter Branch Name
read -p "Enter Branch Name of $repo_name: " branch_name
mkdir -p ./$branch_name && cd ./$branch_name

#Cloning Repo of Particular Branch
git clone git@github.com:arshsahzad/$repo_name.git -b $branch_name
cd ..

#While Run Branch is = 0
branch_count=$(( $branch_count - 1 ))
done