variable "lb_ARN" {}
variable "redirection_url" {}
variable "name_TG" {}
variable "vpc_id" {}
variable "healthcheck_path" {}
variable "healthcheck_statusCode" {}
#variable "attach_instanceId" {}
variable "target_port" {
  default="80"
}
variable "instance_ids" {
	type = list
	default = []
}
resource "aws_lb_listener_rule" "redirection_rule" {
  listener_arn = "${var.lb_ARN}"
  
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
  port     = var.target_port
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

  lifecycle {
    create_before_destroy = true
  }
}




resource "aws_lb_target_group_attachment" "attach_server" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.instance_ids[count.index]
  port             = var.target_port
}
