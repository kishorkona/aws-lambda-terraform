variable "smass_application_id" {
  type = string
  default = "ap145930"
  description = "application id in smass to retrieve secrets"
}
variable "smass_environment" {
  type = string
  default = "DIT1"
  description = "environment in smass to retrieve secrets from"
}
variable "smass_partial_secrets" {
  type = bool
  default = true
  description = "whether the smass secrets is for partial for consolidated secrets"
}
variable "smass_region" {
  type = string
  default = "AWS-US-EAST-1"
  description = "smass region to retrieve secrets from"
}
variable "kms_key_id" {
  type = string
  default = "xxxxxxxx-xxxxxxxx-xxxxxxxx-xxxxxxxx"
  description = "kms key id or arn for encrypting secrets"
}
variable "secrets_name" {
  type = string
  default = "kishorSecrets"
  description = "Name of the secrets(space) where all the secrets of the application are restored"
}