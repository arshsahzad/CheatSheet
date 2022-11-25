#!/bin/bash

# Settings / Change This To Your Config
volumeDir="/opt/sonarqube/"
backupDir="/opt/backup/sonarqube/"
bucketDir="s3://oodles-infra-backups/sonarqube-backups/"
dateFormat=$(date "+%d-%m-%Y-%H%M%S")
fileName=$"$dateFormat-SonarQube.tar.gz"
keepDays=3

# Stop Execution If Found Any Error
set -e

# Backup Process Started
echo
echo "Backup Process Started... $(date "+%T-%d/%m/%Y-%Z")"
echo

# Create Backup Directory If Not Exist
if [[ -d $backupDir ]]
then
echo "Backup Directory $backupDir Already Exist"
else
mkdir -p $backupDir
echo "Creating Backup Directory $backupDir"
fi

# Create Compressed Tar In Backup Directory
echo
echo "Compressing $volumeDir... $(date "+%T")"
tar -czf $backupDir$fileName -P $volumeDir
echo
echo "Compression Completed..."
echo "$(du -sh $fileName) $(date "+%T")"
echo "......................................................."

# Uploading Compressed Tar To Amazon S3
echo
/usr/local/bin/aws s3 cp $backupDir$fileName $bucketDir
echo "Uploading Compressed File To Amazon S3... $(date "+%T")"
echo
/usr/local/bin/aws s3 ls $bucketDir$fileName --recursive --human-readable --summarize
echo
echo "Compressed File Upload Completed... $(date "+%T")"
echo "............................................."

# Change Directory To Backup
if [ ! -z ${backupDir} ]; then
cd ${backupDir}

# Delete Backup Older Than 3 Days
echo
echo "Deleting Older Tar Volume Backup..."
echo
find . -name "*.tar.gz" -mtime +$keepDays -exec rm -rf {} \;
fi

echo
echo "Backup Process Completed... $(date "+%T-%d/%m/%Y-%Z")"
echo