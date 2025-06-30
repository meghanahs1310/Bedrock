provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = "172.31.0.0/16"
  private_subnet_cidrs = ["172.31.32.0/20", "172.31.0.0/20"]
  azs                  = ["us-east-1a", "us-east-1b"]
}

module "iam" {
  source = "./modules/iam"
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}

module "glue" {
  source         = "./modules/glue"
  glue_role_arn  = module.iam.bedrock_role_arn
  s3_input_path  = "s3://your-bucket/input/"
}

module "bedrock" {
  source             = "./modules/bedrock"
  execution_role_arn = module.iam.bedrock_role_arn
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
}
