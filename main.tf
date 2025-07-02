provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = "172.31.0.0/16"
  private_subnet_cidrs = ["172.31.32.0/20", "172.31.0.0/20"]
  azs                  = ["us-east-1a", "us-east-1b"]
}


module "cloudwatch" {
  source = "./modules/cloudwatch"
}

module "iam" {
  source = "./modules/iam"
}
module "glue" {
  source             = "./modules/glue"

  glue_database_name = "bedrock_database"
  glue_crawler_name  = "bedrock_crawler"
  glue_job_name      = "bedrock_job"
  glue_role_arn      = module.iam.glue_role_arn
  script_path        = "s3://your-bucket/scripts/sample_glue_job.py"
  s3_input_path      = "s3://bedrock-glue-scripts-bucket/input/"
  subnet_ids         = module.vpc.private_subnet_ids
}


module "bedrock" {
  source             = "./modules/bedrock"
  execution_role_arn = module.iam.bedrock_role_arn
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
}
