module "cloudwatch_rules" {
  source = "./cloudwatch_event_rules"
  event_name = var.event_name
  function_name = var.function_name
  is_cloudwatch_event_enabled = var.is_cloudwatch_event_enabled
}
locals {
  rule_names = chunklist(module.cloudwatch_rules, 3)
  intra_day_sec_master_files = var.sec_master_file_name["intra_day"]
  is_cloudwatch_event_enable = var.is_cloudwatch_event_enabled
  intra_day_targets = [
    for intraPair in setproduct(local.rule_names[0], local.intra_day_sec_master_files) : {
      rule_name = intraPair[0]
      target_sub_id = intraPair[1]
    }
  ]
}

resource "aws_cloudwatch_event_target" "intra_day_trigger" {
  arn  = var.lambda_arn
  retry_policy {
    maximum_event_age_in_seconds = 60
    maximum_retry_attempts = 3
  }
  for_each = {
    for intra_target_rule in local.intra_day_targets: "${intra_target_rule.rule_name}_${intra_target_rule.target_sub_id}" => intra_target_rule
  }
  rule = each.value.rule_name
  target_id = each.key
  input = "{\"input\": \"{each.value.target_sub_id}\",\"secretsName\":\"testSecrets\", \"action\": \"DOWNLOAD\"}"
}