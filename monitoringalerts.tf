resource "aws_sns_topic" "app_alerts" {
  name = "app-alerts-topic"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.app_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_log_metric_filter" "error_filter" {
  name           = "app-error-filter"
  log_group_name = "/ec2/app-logs"
  pattern        = "?ERROR ?Exception"

  metric_transformation {
    name      = "AppErrorCount"
    namespace = "EC2AppLogs"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "error_alarm" {
  alarm_name          = "AppErrorAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = aws_cloudwatch_log_metric_filter.error_filter.metric_transformation[0].name
  namespace           = aws_cloudwatch_log_metric_filter.error_filter.metric_transformation[0].namespace
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "Triggers when app logs have errors or exceptions."
  alarm_actions       = [aws_sns_topic.app_alerts.arn]
}
