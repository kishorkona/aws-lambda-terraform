resource "aws_cloudwatch_event_rule" "eventbridge_intra_daily_730_to_755" {
  name = join("_",[var.event_name[0], "730_to_755"])
  schedule_expression = "cron(25,30,35,40,45,50,55 12 ? * MON-FRI *)"
  description = "Run every 5 mins on the weekdays from 7:25 to 7:55"
  is_enabled = var.is_cloudwatch_event_enable
}
resource "aws_cloudwatch_event_rule" "eventbridge_intra_daily_800_to_1900" {
  name = join("_",[var.event_name[0], "800_to_1900"])
  schedule_expression = "cron(0/5 13-23 ? * MON-FRI *)"
  description = "Run every 5 mins on the weekdays from 8:00 to 19:00"
  is_enabled = var.is_cloudwatch_event_enable
}
resource "aws_cloudwatch_event_rule" "eventbridge_intra_daily_1900_to_1910" {
  name = join("_",[var.event_name[0], "1900_to_1910"])
  schedule_expression = "cron(5,10 0 ? * TUE-SAT *)"
  description = "Run every 5 mins on the weekdays from 19:00 to 19:10"
  is_enabled = var.is_cloudwatch_event_enable
}
resource "aws_lambda_permission" "intraday_cloudwatch_730_to_755" {
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.eventbridge_intra_daily_730_to_755.arn
  statement_id = join("_",["AllowExecFromCloudWatch","intraday_730_to_755"])
}
resource "aws_lambda_permission" "intraday_cloudwatch_800_to_1900" {
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.eventbridge_intra_daily_800_to_1900
  statement_id = join("_",["AllowExecFromCloudWatch","intraday_800_to_1900"])
}
resource "aws_lambda_permission" "intraday_cloudwatch_800_to_1900" {
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.eventbridge_intra_daily_1900_to_1910
  statement_id = join("_",["AllowExecFromCloudWatch","intraday_1900_to_1910"])
}
variable "function_name" {
  type = string
  description = "cloud watch event trigerring the lambda function name"
}
variable "event_name" {
  type = list(string)
  description = "list of different events being created as rules"
}
variable "is_cloudwatch_event_enable" {
  type = bool
  default = false
  description = "whether s3 cloudwatch event should be enabled"
}
output "rule_names" {
  value = [aws_cloudwatch_event_rule.eventbridge_intra_daily_730_to_755.name,
  aws_cloudwatch_event_rule.eventbridge_intra_daily_800_to_1900.name,
  aws_cloudwatch_event_rule.eventbridge_intra_daily_1900_to_1910.name]
}