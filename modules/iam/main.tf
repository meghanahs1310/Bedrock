resource "aws_iam_role" "bedrock" {
  name = "bedrock-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "bedrock.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "bedrock_policy" {
  name = "bedrock-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "bedrock:*",
        "logs:*",
        "s3:*",
        "glue:*"
      ],
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.bedrock.name
  policy_arn = aws_iam_policy.bedrock_policy.arn
}

output "bedrock_role_arn" {
  value = aws_iam_role.bedrock.arn
}
