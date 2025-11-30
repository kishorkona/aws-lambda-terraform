resource "aws_s3_bucket_object" "lambda_upload" {
  bucket = "${var.s3BucketName}"
  key    = "lambda-functions/${var.lambda_function_name}/${var.env}/${var.applicationId}/${var.lambda_function_name}-app.jar"
  source = var.file_name
  etag = try(filemd5(var.file_name),null)
}
resource "aws_lambda_function" "fidLambda" {
  depends_on = [aws_s3_bucket_object.lambda_upload]
  function_name = var.lambda_function_name
  s3_bucket = "${var.s3BucketName}"
  s3_key = aws_s3_bucket_object.lambda_upload.key
  description = "Test Lambda function"
  role          = var.aws_lambda_role
  handler = var.handler_name
  memory_size = var.memory_size
  source_code_hash = filebase64sha256(var.file_name)
  reserved_concurrent_executions = 11
  runtime = var.runtime
  layers = [aws_lambda_layer_version.certsAndTrustStoreLayer.arn]
  timeout = 150
  tags = local.common_tags
  vpc_config {
    security_group_ids = data.aws_security_groups.security_groups.ids
    subnet_ids         = data.aws_subnet_ids.subnet_ids.ids
  }
  environment {
    variables = {
      user = var.user
      trustedCA = var.trustedCA
      keyPair = var.keypair
      kafkaTrustedCA = var.kafkaTrustedCA
      dbUser = var.dbUser
      dbUrl = var.dbUrl
      route53Url = var.route53Url
      s3BucketName = var.s3BucketName
      smtpHost = var.smtpHost
      mailFrom = var.mailFrom
      mailTo = var.mailTo
      mailServer = var.mailServer
      subject = var.subject
      jksFile = var.jksFile
      env = var.env
      is_cloudwatch_event_enabled = var.is_cloudwatch_event_enabled
      region = var.region
    }
  }
}
resource "aws_cloudwatch_log_group" "fidlambda_log_group" {
  name = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
  tags = local.common_tags
}
resource "aws_lambda_permission" "cloudwatch" {
  depends_on = [aws_lambda_function.fidLambda]
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fidLambda.arn
  principal     = "events.amazonaws.com"
  statement_id = "AllowExecutionFromCloudWatch"
}
resource "aws_lambda_permission" "datadog" {
  depends_on = [aws_cloudwatch_log_group.fidlambda_log_group]
  action        = "lambda:InvokeFunction"
  function_name = "LogandTeletry-DatadogLogs_Transmitter"
  principal     = "logs.amazonaws.com"
  statement_id = format("AllowExecution_from_%s",aws_lambda_function.fidLambda.function_name)
  source_arn = format("%s;*",aws_cloudwatch_log_group.fidlambda_log_group.arn)
}
resource "aws_cloudwatch_log_subscription_filter" "datadog_subscription" {
  depends_on = [aws_cloudwatch_log_group.fidlambda_log_group]
  destination_arn = data.aws_lambda_function.DatadogLogs_Transmitter
  filter_pattern  = ""
  log_group_name  = aws_cloudwatch_log_group.fidlambda_log_group.arn
  name            = "${var.lambda_function_name}-datadog-subscription"
  distribution = "Random"
}
resource "aws_lambda_layer_version" "certsAndTrustStoreLayer" {
  description = "lambda layers"
  layer_name = "certsAndTrustStoreLayer"
  compatible_architectures = ["x86_64","arm64"]
  compatible_runtimes = ["java17"]
  filename = "./modules/fidlambda/certsAndTrustStore.zip"
  skip_destroy = false
}