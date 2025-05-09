#!/bin/bash

#Define source directory and destination directory
DATE=$(date +%F)
SOURCE_DIR="/var/lib/jenkins"
DEST_DIR="/home/ubuntu/jenkins_backup-$DATE"

# Gracefully stop the jenkins before taking the backup
sudo systemctl stop jenkins

#make sure the dest dir is present
mkdir -p "$DEST_DIR"
sudo cp -r "$SOURCE_DIR"/* "$DEST_DIR"

#Restart the jenkins after the backup
sudo systemctl start jenkins

#Compress or Archive the backup folder
tar -czf "$DEST_DIR.tar.gz." -C /home/ubuntu "jenkins_backup-$DATE"
rm -rf $DEST_DIR
