provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "techeazy_instance" {
  ami                         = "ami-0447a12f28fddb066"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-08bedab1563d4fd48"
  vpc_security_group_ids      = ["sg-00a932d53b6449e9f"]
  iam_instance_profile        = aws_iam_instance_profile.cloudwatch_agent_profile.name
  associate_public_ip_address = true

  user_data = file("${path.module}/monitoring/user-data.sh")

  tags = {
    Name = "techeazy-cloudwatch-instance"
  }
}

resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/ec2/app-logs"
  retention_in_days = 7
}

resource "aws_sns_topic" "app_alerts_topic" {
  name = "app-alerts-topic"
}

