# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "slapi_log_group" {
  name              = "/ecs/${var.company}-${var.product}-app-${var.sdlc}"
  retention_in_days = 30

  tags = {
    Name = "${var.product}-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "slapi_log_stream" {
  name           = "${var.company}-${var.product}-log-stream-${var.sdlc}"
  log_group_name = aws_cloudwatch_log_group.slapi_log_group.name
}

