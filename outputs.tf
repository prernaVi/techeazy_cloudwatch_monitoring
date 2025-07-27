output "ec2_public_ip" {
  value = aws_instance.techeazy_instance.public_ip
}

output "sns_topic_arn" {
  value = aws_sns_topic.app_alerts_topic.arn
}

output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.app_log_group.name
}
