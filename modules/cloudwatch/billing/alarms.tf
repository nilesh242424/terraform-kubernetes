resource "aws_cloudwatch_metric_alarm" "estimated_charges" {
  alarm_name          = "Billing: estimated charges"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"

  dimensions = {
    Currency = "USD"
  }

  period            = "21600"
  statistic         = "Maximum"
  threshold         = "2500"
  alarm_description = "Estimated charges"
  alarm_actions     = var.alarmActions
  ok_actions        = var.okActions
}

