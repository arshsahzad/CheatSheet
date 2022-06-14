#!/bin/bash

# Settings / Change This To Your Config
remoteBucket=arshsahzad
credProfile="--profile storj"
credConfig="$HOME/.aws"
remoteDir="s3://$remoteBucket/BakOps/"
localDir="$HOME/devops/projects/LinkTree"
remoteEndpoint=" https://gateway.ap1.storjshare.io"

# Check If Credentials File Exists.
if ! grep -q aws_access_key_id $credConfig/config; then
    if ! grep -q aws_access_key_id $credConfig/credentials; then
    echo
    echo "*****************************************************"
    echo "**    AWS Config Not Found or CLI Not Installed    **"
    echo "**            Please Run {aws configure}           **"
    echo "*****************************************************"
    echo
    exit 1
    fi
fi

#  Exit On Error
set -e

echo
echo "Choose From the Options Below to Copy or Sync:"
echo
echo "1. Copy"
echo "2. Sync"  
echo "3. Exit"
echo
echo "Enter Your Choice:"
read choice


case $choice in
    
    1)  # Copying Files from Local to Remote.
        echo "***********************************************"
        echo "**    Copying Files from Local to Remote     **"
        echo "**                Please Wait...             **"  
        echo "***********************************************"
        echo
        aws $remoteEndpoint s3 cp $localDir $remoteDir --recursive $credProfile
        status=$?
        echo
        echo "**********************************************"
        echo "**    Copying Files from Local to Remote    **"
        echo "**                 Completed...             **"
        echo "**********************************************"
        ;;

    2)  # Syncing Files from Local to Remote.
        echo "***********************************************"
        echo "**    Syncing Files from Local to Remote     **"
        echo "**                Please Wait...             **"  
        echo "***********************************************"
        echo
        aws $remoteEndpoint s3 cp $localDir $remoteDir --recursive $credProfile
        status=$?
        echo
        echo "**********************************************"
        echo "**    Syncing Files from Local to Remote    **"
        echo "**                 Completed...             **"
        echo "**********************************************"
esac