/*
this needs to be run only once if the secrets manager key does not exist
*/
module "fidsm" {
  source = "./modules/fidSecretsManager"
  smass_application_id = var.smass_application_id
  smass_environment = var.smass_environment
  smass_region = var.smass_region
  secrets_name = var.secrets_name
  kms_key_id = var.kms_key_id
  smass_partial_secrets = var.smass_partial_secrets
  providers = {
    fidsmass = fidsmass
  }
}