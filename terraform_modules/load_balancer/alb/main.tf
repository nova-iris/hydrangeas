# Create Security Group for ALB
resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id

  # Allow inbound HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create ALB
resource "aws_lb" "this" {
  name               = "${var.name_prefix}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnets

  enable_deletion_protection = false
}

# Create Listener for ALB (HTTP)
# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.this.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.my_tg.arn
#   }
# }

# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = 80
#   protocol          = "HTTP"
#   default_action {
#     type = "fixed-response"
#     fixed_response {
#       content_type = "text/plain"
#       message_body = "Default Response"
#       status_code  = "404"
#     }
#   }
# }

# resource "aws_lb_listener_rule" "rules" {
#   count        = length(var.alb_listener_rules)
#   listener_arn = aws_lb_listener.http.arn
#   priority     = var.alb_listener_rules[count.index].priority

#   dynamic "condition" {
#     for_each = var.alb_listener_rules[count.index].conditions
#     content {
#       field  = condition.value.field
#       values = condition.value.values
#     }
#   }

#   dynamic "action" {
#     for_each = var.alb_listener_rules[count.index].actions
#     content {
#       type = action.value.type

#       dynamic "target_group_arn" {
#         for_each = action.value.type == "forward" ? [1] : []
#         content {
#           target_group_arn = action.value.target_group_arn
#         }
#       }

#       dynamic "redirect" {
#         for_each = action.value.type == "redirect" ? [1] : []
#         content {
#           protocol    = action.value.redirect.protocol
#           port        = action.value.redirect.port
#           status_code = action.value.redirect.status_code
#         }
#       }
#     }
#   }
# }
