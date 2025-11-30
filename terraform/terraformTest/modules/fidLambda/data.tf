data "aws_vpc" "vpc" {
  id = var.vpc_id
}
data "aws_subnet_ids" "subnet_ids" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "tag:Name"
    values = var.subnets
  }
}
data "aws_lambda_function" "DatadogLogs_Transmitter" {
  function_name = "LogandTelemetry.DatadogLogs_Transmitter"
}
data "aws_security_groups" "security_groups" {
  filter {
    name   = "group_name"
    values = var.securityGroups
  }
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}
data "archive_file" "certsAndTrustStore" {
  source_dir = "././jks"
  output_path = "./modules/fidLambda/certsAndTrustStore.zip"
  type        = "zip"
}