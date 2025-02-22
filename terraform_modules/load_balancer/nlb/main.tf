resource "aws_lb" "this" {
  name               = "${var.name_prefix}-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnets

  enable_deletion_protection = false

  tags = {
    Name = "${var.name_prefix}-nlb"
    ManagedBy = "Terraform"
  }
}

resource "aws_lb_target_group" "this" {
  name        = "${var.name_prefix}-nlb-tg"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id

  health_check {
    protocol            = "TCP"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "nlb_targets" {
  count            = length(var.ec2_ids)
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.ec2_ids[count.index]
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}