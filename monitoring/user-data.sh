#!/bin/bash
set -e

sudo yum update -y
sudo yum install -y amazon-cloudwatch-agent

mkdir -p /opt/aws/amazon-cloudwatch-agent/etc
cd /opt/aws/amazon-cloudwatch-agent/etc

aws s3 cp https://raw.githubusercontent.com/prernaVi/techeazy_cloudwatch_monitoring/main/monitoring/cloudwatch-config.json ./cloudwatch-config.json

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/cloudwatch-config.json \
  -s
