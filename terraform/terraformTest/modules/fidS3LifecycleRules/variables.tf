variable "s3BucketName" {
  type = string
  description = "S3 bucker amazon resource name"
}
variable "prefix" {
  type = string
  description = "folder from which the object is supposed to be deleted"
}
variable "intraday_file_expires_in_days" {
  type = number
  description = "valid days for intraday files"
}
variable "tag_value_intraday" {
  type = string
  description = "value for intraday tag"
}
variable "eod_file_expires_in_days" {
  type = number
  description = "valid days for eod files"
}
variable "tag_value_eod" {
  type = number
  description = "value of eod tag"
}
variable "sec_master_file_name" {
  type = map(any)
  description = "name of the job that needs to be run"
}
variable "kms_master_key_id" {
  type = string
  description = "value for the KMS key id"
}