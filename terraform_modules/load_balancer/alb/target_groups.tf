
# Create Target Group for ALB
resource "aws_lb_target_group" "my_tg" {
  name     = "${var.name_prefix}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Register EC2 with Target Group
resource "aws_lb_target_group_attachment" "tg_attach" {
  count = length(var.ec2_ids)

  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = var.ec2_ids[count.index]
  port            = 80
}