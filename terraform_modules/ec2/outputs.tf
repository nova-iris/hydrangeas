
output "public_ip" {
    description = "EC2 Instance Public IP"
    value = aws_instance.this.public_ip
}

output "instance_id" {
  description = "EC2 ID"
  value = aws_instance.this.id
}