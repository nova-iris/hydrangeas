resource "aws_key_pair" "ec2_key" {
  key_name   = "${var.service_name}-${var.instance_name}-key"
  public_key = file("${var.ssh_private_key}.pub")
}

resource "aws_security_group" "ec2_sg" {
  name = "${var.service_name}-${var.instance_name}-sg"
  description = "Security group for EC2 instances ${var.service_name}-${var.instance_name}"
  vpc_id = var.vpc_id
   dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = var.security_group_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [ aws_security_group.ec2_sg.id ]
  subnet_id = var.subnet_id
  
  tags = var.tags
}