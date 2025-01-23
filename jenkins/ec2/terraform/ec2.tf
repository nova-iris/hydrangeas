resource "aws_key_pair" "ec2_key" {
  key_name   = "${var.service_name}-key"
  public_key = file("${var.ssh_private_key}.pub")
}

resource "aws_security_group" "ec2_sg" {
  name = "${var.service_name}-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

#   vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [ aws_security_group.ec2_sg.id ]

#   network_interface {
#     network_interface_id = var.network_interface_id
#     device_index         = 0
#   }

  credit_specification {
    cpu_credits = "unlimited"
  }
}

output "instance_ip_public" {
  value = aws_instance.ec2_instance.public_ip
}