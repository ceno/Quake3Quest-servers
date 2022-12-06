#!/bin/bash

ssh  ec2-user@$1 df -h | grep /dev/nvme0n1p1 | grep -v /dev/nvme0n1p128
ssh  ec2-user@$1 'sudo du -h -s /*' 2>&1 | sort -h  | grep -v "cannot access"
ssh  ec2-user@$1 'sudo du -h -s /var/log/*'  2>&1 | sort -h | grep -v "cannot access"
