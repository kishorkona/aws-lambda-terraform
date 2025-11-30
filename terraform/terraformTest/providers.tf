terraform {
  required_version = ">= 0.12.26"
  backend "http" {}
  required_providers {
    aws = "~> 4.0"
    fidsmass = {
      source = "fid.com/edu/fidsmass"
    }
    fidvenafi = {
      source = "fid.com/edu/fidvenafi"
    }
  }
}
provider "fidsmass" {
  username = var.service_account_username
  password = var.service_account_password
}
provider "fidvenafi" {
  url = var.venafi_url
  tpp_username = var.service_account_username
  tpp_password = var.service_account_password
  zone = var.venafi_zone
}
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      environment = var.env
      productid = var.product_id
      product_line_id = var.product_line_id
      account_number = var.account_number
      retainresources = true
      datadog = false
      applicationid = var.application_id
    }
  }
}