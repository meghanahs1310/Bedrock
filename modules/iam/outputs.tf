output "bedrock_role_arn" {
  value = aws_iam_role.bedrock.arn
}

output "glue_role_arn" {
  value = aws_iam_role.glue.arn
}
