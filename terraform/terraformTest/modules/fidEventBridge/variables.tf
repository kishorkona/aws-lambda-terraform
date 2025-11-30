variable "env" {
  type = string
  description = "environment of the cloud watch event"
}
variable "event_name" {
  type = list(string)
  description = "event bridge event name that triggers the lambda"
}
variable "role_arn" {
  type = string
  description = "role full qualified resource name"
}
variable "lambda_arn" {
  type = string
  description = "lambda arn"
}
variable "function_name" {
  type = map(any)
  description = "cloud watch event trigerring the lambda function name"
}
variable "sec_master_file_name" {
  type = map(any)
  description = "name of the job that needs to run"
}
variable "is_cloudwatch_event_enabled" {
  type = bool
  description = "whether s3 cloudwatch event should be enabled"
  default = false
}
