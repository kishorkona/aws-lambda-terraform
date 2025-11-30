module "fideventbridge" {
  source = "./modules/fidEventBridge"
  env = var.env
  event_name = var.event_name
  role_arn = var.role_arn
  lambda_arn = module.fideventbridg
  function_name = var.lambda_function_name
  sec_master_file_name = var.sec_master_file_name
  is_cloudwatch_event_enabled = var.is_cloudwatch_event_enabled
}