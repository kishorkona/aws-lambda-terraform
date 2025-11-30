resource "aws_s3_bucket" "kishorS3bucketrules" {
  bucket = var.s3BucketName
  dynamic "lifecycle_rule" {
    for_each = var.sec_master_file_name["intra_day"]
    iterator = file
    content {
      expiration {
        days = var.intraday_file_expires_in_days
      }
      prefix = var.prefix
      tags = {
        (file.value) = var.tag_value_intraday
      }
      id = join("-",["intraday-rule","${file.value}"])
      enabled = true
    }
  }
  dynamic "lifecycle_rule" {
    for_each = var.sec_master_file_name["intra_day"]
    iterator = file
    content {
      expiration {
        days = var.eod_file_expires_in_days
      }
      prefix = var.prefix
      tags = {
        (file.value) = var.tag_value_eod
      }
      id = join("-",["intraday-rule","${file.value}"])
      enabled = true
    }
  }
  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = false
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_master_key_id
        sse_algorithm = "aws:kms"
      }
    }
  }
}