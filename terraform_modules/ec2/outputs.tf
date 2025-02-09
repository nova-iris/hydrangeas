
output "ec2_public_ip" {
    description = "EC2 Instance Public IP"
    value = aws_instance.this.public_ip
}