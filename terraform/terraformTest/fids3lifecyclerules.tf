module "fids3lifecyclerules" {
  source = "./modules/fidS3LifecycleRules"
  s3BucketName = var.s3BucketName
  prefix = var.prefix
  intraday_file_expires_in_days = var.intraday_file_expires_in_days
  tag_value_intraday = var.tag_value_intraday
  tag_value_eod = var.tag_value_eod
  eod_file_expires_in_days = var.eod_file_expires_in_days
  sec_master_file_name = var.sec_master_file_name
  kms_master_key_id = var.kms_master_key_id
}