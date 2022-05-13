#!/bin/bash

#Get Repo Count
read -p "How Many Repo You Want To Clone: " repo_count

while [ $repo_count -gt 0 ]
do
#Type Repo Name
read -p "Enter Repo Name: " repo_name
mkdir -p ./$repo_name && cd ./$repo_name

#Get Repo Branch Count
read -p "How Many Repo Branch You Want To Clone: " branch_count

#Type  Branch Name
read -p "Enter Branch Name: " branch_name
repo_count=$(( $repo_count - 1 ))
mkdir -p ./$branch_name && cd ./$branch_name

#Cloning Repo of Particular Branch
git clone git@github.com:arshsahzad/$repo_name.git -b $branch_name
cd ../
branch_count=$(( $branch_count - 1 ))
done