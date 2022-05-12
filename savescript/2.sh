#!/bin/bash
#get repo number
read -p "How Many Repo You Want To Clone:" reponum

#take username&password

read -p "enter git username: " username 
read -p "enter git password: " password

#urlencode password to use it in https without any issues

epassword=$(php -r "echo urlencode('$password');")

while ((reponum--))
do
#take repo name without .git at the end
read -p "enter repo name: " reponame

git clone "https://$username:$epassword@github.com/$username/$reponame.git"
done