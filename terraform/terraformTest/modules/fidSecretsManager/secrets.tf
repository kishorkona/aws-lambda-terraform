data "fidsmass_token" "app_secrets" {
  applicaiton_id = var.smass_application_id
  environment = var.smass_environment
  region = var.smass_region
  partial_secrets = var.smass_partial_secrets
}
resource "aws_secretsmanager_secret" "kishor_secrets" {
  name = var.secrets_name
  kms_key_id = var.kms_key_id
}
resource "aws_secretsmanager_secret_version" "kishor_secrets_version" {
  depends_on = [aws_secretsmanager_secret.kishor_secrets]
  secret_id = aws_secretsmanager_secret.kishor_secrets.id
  secret_string = jsonencode(data.fidsmass_token.app_secrets.tokens)
}
terraform {
  required_providers {
    fidsmass = {
      source = "fid.com/edu/fidsmass"
    }
  }
}
