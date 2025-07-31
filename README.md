 TechEazy CloudWatch Monitoring Infrastructure

This project sets up CloudWatch monitoring for an EC2-hosted Spring Boot application using Terraform. It includes log collection, CloudWatch Alarms, and SNS notifications, automating observability setup for production-like environments.
✅ Objectives Achieved

    Stream application logs from EC2 to CloudWatch Logs

    Set up a CloudWatch Alarm to monitor ERROR/Exception patterns

    Send email alerts via Amazon SNS when alarm triggers

    Use Terraform to manage all AWS resources

📁 Directory Structure

.
├── cloudwatch-agent-config.json      # Config for CloudWatch agent
├── ec2_setup.sh                      # Optional helper to configure EC2
├── main.tf                           # Core Terraform config
├── monitoringiam.tf                 # IAM roles/policies for EC2 instance
├── monitoringalerts.tf              # SNS topic, log metric filter, and CloudWatch alarm
├── monitoringassume-role-policy.json# IAM trust policy
├── outputs.tf                        # Terraform output definitions
├── terraform.tfvars                 # User-defined variable values
├── variables.tf                      # Variable declarations

🔧 AWS Resources Used

    EC2 Instance (Ubuntu-based, AMI ID: ami-0447a12f28fddb066)

    IAM Role & Instance Profile

    CloudWatch Agent with custom config

    SNS Topic with email subscription

    CloudWatch Logs & Alarm

📬 SNS Email Alerts

Alerts are triggered when the log stream contains the keywords ERROR or Exception.

📩 Alert Email: repo_owneremail@gmail.com
🚀 Deployment Steps

    Clone the repo:

git clone https://github.com/prernaVi/techeazy_cloudwatch_monitoring.git
cd techeazy_cloudwatch_monitoring

Initialize Terraform:

terraform init

Apply configuration:

terraform apply -auto-approve

SSH into EC2 and simulate an error:

    echo "ERROR: Simulated failure on $(date)" >> /home/ec2-user/app.log

    Check CloudWatch Log Groups and confirm SNS email alert.

🛡️ Notes

    Up to 5GB log ingestion per month is free under CloudWatch Free Tier.

    Ensure that your EC2 IAM role has CloudWatchAgentServerPolicy and AmazonSSMManagedInstanceCore.

    All resources are deployed in the ap-south-1 (Mumbai) region.

📎 Useful Links

    Terraform AWS Provider Docs

    Amazon CloudWatch Agent Setup

    SNS Notification Pricing

