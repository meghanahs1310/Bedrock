variable "glue_database_name" {}
variable "glue_crawler_name" {}
variable "glue_job_name" {}
variable "glue_role_arn" {}
variable "script_path" {}
variable "s3_input_path" {}
variable "subnet_ids" {
  type = list(string)
}
