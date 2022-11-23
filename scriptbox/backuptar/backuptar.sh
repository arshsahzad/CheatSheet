#!/bin/bash

# Settings / Change This To Your Config
volumeDir="/opt/gitlab/"
backupDir="/opt/bakops/gitlab/"
bucketDir="s3://oodles-infra-backups/gitlab-oodleslab-com/gitlab-fullbackup/"
dateFormat=$(date "+%d-%m-%Y-%H%M%S")
fileName=$"$dateFormat-GitLab.tar.gz"
keepDays=3

set -e

echo "$dateFormat"

# Create Tar in Backup Directory
echo "Generating GitLab Tar For Backup"
tar -cvzf $backupDir$fileName -P $volumeDir

# Upload Tar Backup to Amazon S3
aws s3 cp $backupDir$fileName $bucketDir

# Delete Old Tar Backup
if [ ! -z ${backupDir} ]; then
cd ${backupDir}
echo "Deleting Backups Older Than $keepDays Days"
find . -name "*.tar.gz" -mtime +$keepDays -exec rm -rf {} \;
fi