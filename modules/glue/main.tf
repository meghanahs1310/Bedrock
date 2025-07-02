resource "aws_glue_catalog_database" "bedrock_db" {
  name = "bedrock_database"
}

resource "aws_glue_crawler" "bedrock_crawler" {
  name          = "bedrock-crawler"
  role          = var.glue_role_arn
  database_name = aws_glue_catalog_database.bedrock_db.name

  s3_target {
    path = var.s3_input_path
  }
}

output "glue_database_name" {
  value = aws_glue_catalog_database.bedrock_db.name
}