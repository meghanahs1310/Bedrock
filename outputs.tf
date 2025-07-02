output "bedrock_role_arn" {
  value = module.iam.bedrock_role_arn
}


output "vpc_id" {
  value = module.bedrock.vpc_id
}
