#!/bin/bash

# Settings / Change This To Your Config
volumeDir="/opt/gitlab/"
backupDir="/opt/backup/gitlab/"
bucketDir="s3://oodles-infra-backups/gitlab-backups/"
dateFormat=$(date "+%d-%m-%Y-%H%M%S")
fileName=$"$dateFormat-GitLab.tar.gz"
keepDays=3

# Stops Execution If Error
set -e

# Printout Date & Time
echo "$dateFormat"

# Create Backup Directory If Not Exist
if [[ -d $backupDir ]]
then
echo "$backupDir Already Exist"
else
echo "Creating $backupDir Directory"
mkdir -p $backupDir
fi

# Create Compressed Tar In Backup Directory
echo "Generating GitLab Tar For Backup"
tar -cvzf $backupDir$fileName -P $volumeDir

# Upload Compressed Tar To Amazon S3
/usr/bin/aws s3 cp $backupDir$fileName $bucketDir

# Change Directory To Backup
if [ ! -z ${backupDir} ]; then
cd ${backupDir}

# Delete Backup Older Than 3 Days
echo "Deleting Backup Older Than $keepDays Days"
find . -name "*.tar.gz" -mtime +$keepDays -exec rm -rf {} \;
fi