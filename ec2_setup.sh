#!/bin/bash

# Install CloudWatch agent
sudo yum update -y
sudo yum install -y amazon-cloudwatch-agent

# Download CloudWatch agent config from GitHub (you can customize if needed)
curl -o /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  https://raw.githubusercontent.com/prernaVi/techeazy_cloudwatch_monitoring/main/cloudwatch-agent-config.json

# Start CloudWatch Agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s
