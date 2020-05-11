### ALB

resource "aws_alb" "main" {
  name            = "${var.company}-${var.product}-alb-${var.sdlc}"
  subnets         = [data.aws_subnet.public-az1.id, data.aws_subnet.public-az2.id, data.aws_subnet.public-az3.id]
  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "app" {
  name        = "${var.product}-alb-tg-${var.sdlc}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.vpc.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "20"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "5"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
#resource "aws_alb_listener" "front_end" {
#  load_balancer_arn = "${aws_alb.main.id}"
#  port              = "${var.app_port}"
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = "${aws_acm_certificate.cert_arn.id}"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.app.id}"
#    type             = "forward"
#  }
#}
resource "aws_alb_listener" "redirect_80" {
  load_balancer_arn = aws_alb.main.id
  port              = "80"
  protocol          = "HTTP"

  #certificate_arn   = "${aws_acm_certificate.cert_arn.id}"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

/*
resource "aws_alb_listener" "redirect_443" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "${aws_acm_certificate.cert_arn.id}"

  default_action {
    type = "redirect"

    redirect {
      port        = "3000"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
*/
resource "aws_alb_listener" "front_end_443" {
  load_balancer_arn = aws_alb.main.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert_arn.id

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}

