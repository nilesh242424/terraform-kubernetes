variable "alb_name" {}
variable "name_TG" {}
variable "sg_ids" {
 type = list
}
variable "subnet_ids" {
 type = list
}
variable "environment" {}
variable "vpc_id" {}
variable "certificate_arn" {}
variable "attach_instanceId" {}
variable "redirection_url" {}
variable "healthcheck_path" {}
variable "healthcheck_statusCode" {}

resource "aws_lb" "app_loadbalancer" {
  name               = "${var.alb_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = "${var.sg_ids}"
  subnets            = "${var.subnet_ids}"
  enable_deletion_protection = true
  tags = {
    Environment = "${var.environment}"
  }
}

resource "aws_lb_listener" "redirect80to443" {
  load_balancer_arn = aws_lb.swipe_loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "app_loadbalancer" {
  load_balancer_arn  = aws_lb.app_loadbalancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.certificate_arn}"
	
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_listener_rule" "redirection_rule" {
  listener_arn = aws_lb_listener.swipe_loadbalancer.arn
  
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  condition {
    host_header {
      values = ["${var.redirection_url}"]
    }
  }
}


resource "aws_lb_target_group" "target_group" {
  name	   = "${var.name_TG}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 3
    interval            = 30
    protocol            = "HTTP"
    unhealthy_threshold = 2
    path		= "${var.healthcheck_path}"
    matcher		= "${var.healthcheck_statusCode}"
   }

  depends_on = [
    aws_lb.app_loadbalancer
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "attach_server" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = "${var.attach_instanceId}"
  port             = 80
}

