# SME Automated Backup & Disaster Recovery System (AWS)

# Project Overview

Small and Medium Enterprises (SMEs) in Kenya often rely on manual or unreliable backup methods such as external hard drives, which exposes them to data loss during server crashes, accidental deletions or system failures.

This project demonstrates how to design and implement a secure, automated, and cost‑optimized backup and disaster recovery system on AWS , suitable for SMEs, using AWS Free Tier services.

# Business Problem

* Manual backups are error‑prone and inconsistent
* Data loss leads to downtime and revenue loss
* Most SMEs lack disaster recovery plans
* Security and cost constraints limit adoption of enterprise solutions

# Solution Summary

The solution automatically backs up business‑critical files from an EC2 instance to Amazon S3, applies cost‑saving lifecycle rules, enforces zero‑trust security, and enables rapid disaster recovery with measured recovery time.

# Architecture Overview

**Core Components:**

* Amazon EC2 (application server)
* IAM Role (secure access, no credentials stored)
* Amazon S3 (durable backup storage)
* S3 Versioning & Lifecycle Policies (cost control)
* Linux Cron (automation)
* AWS Systems Manager (secure access)

**Data Flow:**

1. Files stored locally on EC2
2. Nightly cron job runs backup script
3. Script uploads data to S3
4. S3 stores encrypted, versioned backups
5. Data can be restored from S3 during failures

# Security Design (Zero Trust Storage)

* S3 Block Public Access enabled
* Default S3 encryption (SSE‑S3)
* IAM Role used instead of access keys
* No public or anonymous access allowed

**Why this matters:** Even if credentials or infrastructure are compromised, data remains protected.

# Implementation Steps

# 1. EC2 Setup

* Amazon Linux 2023 EC2 instance (Free Tier)
* Access via AWS Systems Manager (no SSH exposure)

# 2. Local Data Structure

/data
 ├── documents
 ├── databases
 └── photos

# 3. Backup Script (Bash)

A bash script copies critical files to Amazon S3 and logs execution results.

Key features:

* Timestamped backups
* Logging to /var/log/sme-backup.log
* Uses IAM Role authentication

# 4. Automation

A cron job runs daily at 2:00 AM:

0 2 * * * /home/ssm-user/scripts/backup_to_s3.sh >> /var/log/sme-backup.log 2>&1

# Storage & Cost Optimization

* Single S3 bucket with prefixes (documents/, databases/, photos/, backups/)
* S3 Versioning enabled
* Lifecycle rules transition older versions to cheaper storage
* Fully compatible with AWS Free Tier

# Disaster Recovery Test

# Scenario

Simulated accidental deletion of a backup file on the EC2 instance.

# Recovery Steps

1. Delete local file
2. Restore file from S3
3. Verify file integrity
4. Measure recovery time

# Results

* Recovery Time Objective (RTO): 45 seconds
* Data restored successfully with no corruption

# Evidence

* S3 objects with timestamps
* Cron logs showing successful execution
* Terminal outputs of backup and restore commands

# Skills Demonstrated

* AWS EC2 & S3
* IAM & security best practices
* Linux (permissions, scripting, cron)
* Backup & disaster recovery design
* Cost‑optimized cloud architecture

# Conclusion

This project demonstrates the ability to design and operate a real‑world cloud solution that balances **security, automation, reliability, and cost**, making it ideal for SMEs and entry‑level cloud engineering roles.

