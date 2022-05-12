#!/bin/bash

#get repo count
read -p "How Many Repo You Want To Clone:" repo_count

while [ $repo_count -gt 0 ]
do
#take repo name without .git at the end
read -p "Enter Repo Name: " reponame

git clone "git@github.com:arshsahzad/$reponame.git"
repo_count=$(( $repo_count - 1 ))
done