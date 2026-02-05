#!/bin/bash
# Automated SME Backup Script
# Uploads local data to Amazon S3 with logging

BUCKET="sme-backups-nairobi-sam-2026"
DATE=$(date +%F)
BACKUP_FILE="/home/ssm-user/data/backup-$DATE.txt"
LOG_FILE="/var/log/sme-backup.log"

echo "[$(date)] Starting backup" >> $LOG_FILE

# Create backup file
echo "Backup created on $DATE" > $BACKUP_FILE

# Upload to S3
aws s3 cp $BACKUP_FILE s3://$BUCKET/backups/

if [ $? -eq 0 ]; then
    echo "[$(date)] Backup completed successfully" >> $LOG_FILE
else
    echo "[$(date)] Backup failed" >> $LOG_FILE
fi
