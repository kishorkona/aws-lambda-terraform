variable "file_name" {
  type = string
  description = "name of the file that will be uploaded to lambda function"
}
variable "lambda_function_name" {
  type = string
  description = "name of the lambda function to be invoked"
}
variable "aws_lambda_role" {
  type = string
  description = "role the lambda function should have to execute successfully"
}
variable "handler_name" {
  type = string
  description = "handler of the lambda function"
}
variable "region" {
  type = string
  description = "aws region used when deploying aws resources"
  default = "us-east-1"
}
variable "memory_size" {
  type = string
  description = "maximum runtime memory for the lambda function"
}
variable "user" {
  type = string
  description = "name of the user that has access"
}
variable "trustedCA" {
  type = string
  description = "trustedCA"
}
variable "keypair" {
  type = string
  description = "user certificate to access external site"
}
variable "KafkaKeyPair" {
  type = string
  description = "kafka trusted certificate authority"
}
variable "kafkaTrustedCA" {
  type = string
  description = "kafka trusted certificate authority"
}
variable "dbUser" {
  type = string
  description = "username to access db"
}
variable "dbUrl" {
  type = string
  description = "db url"
}
variable "route53Url" {
  type = string
  description = "url to connect to redis"
}
variable "s3BucketName" {
  type = string
  description = "name of the s3 bucket"
}
variable "vpc_id" {
  type = string
  description = "name of the vpc"
}
variable "securityGroups" {
  type = string
  description = "security groups associated to the lambda function"
}
variable "subnets" {
  type = list(string)
  description = "subnets associated to the lambda function"
}
variable "smtpHost" {
  type = string
  description = "smtp host to relay email alerts"
}
variable "mailServer" {
  type = string
  description = "email server for email alerts"
}
variable "mailFrom" {
  type = string
  description = "mail from"
}
variable "mailTo" {
  type = string
  description = "mail To"
}
variable "subject" {
  type = string
  description = "email subject"
}
variable "applicationId" {
  type = string
  description = "App ID"
}
variable "env" {
  type = string
  description = "environment"
}
variable "datadogindex" {
  type = string
  description = "name of the index"
}
variable "createdBy" {
  type = string
  description = "createdBy"
}
variable "org" {
  type = string
  description = "organization"
}
variable "productline" {
  type = string
}
variable "productid" {
  type = string
}
variable "jksFile" {
  type = string
  description = "JKS File"
}
variable "is_cloudwatch_event_enabled" {
  type = bool
  description = "whether s3 cloudwatch event should be enabled"
  default = true
}
locals {
  fid_hostname = var.region
  csp = "aws"
  applicationId = var.applicationId
  environemnt = var.env
  env = var.env
  fid_env = var.env
  createdBy = var.createdBy
  productlineId = var.productline
  organization = var.org
  productid = var.productid
  index = var.datadogindex
  fid_datadog_service = "${var.lambda_function_name}-${var.env}"
  service = "${var.lambda_function_name}-${var.env}"
  app_name = "${var.lambda_function_name}-${var.env}"
  datadog = "true"
}