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

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.app_alerts_topic.arn
  protocol  = "email"
  endpoint  = "prernaupadhyay.505@gmail.com"
}

resource "aws_cloudwatch_log_metric_filter" "error_filter" {
  name           = "error-metric-filter"
  log_group_name = aws_cloudwatch_log_group.app_log_group.name
  pattern        = "ERROR"

  metric_transformation {
    name      = "ErrorCount"
    namespace = "AppLogs"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "error_alarm" {
  alarm_name          = "app-error-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ErrorCount"
  namespace           = "AppLogs"
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  alarm_description   = "Alarm if error count >= 1 in app logs"
  alarm_actions       = [aws_sns_topic.app_alerts_topic.arn]
}
