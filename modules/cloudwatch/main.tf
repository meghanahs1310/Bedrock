resource "aws_cloudwatch_log_group" "bedrock_log" {
  name              = "/aws/bedrock/logs"
  retention_in_days = 7
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.bedrock_log.name
}