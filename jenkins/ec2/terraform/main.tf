
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tftpl",
    {
      ip = aws_instance.ec2_instance.public_ip
      service_name = var.service_name
      ansible_user = "ec2-user"
      ssh_private_key_file = var.ssh_private_key
    }
  )
  filename = "${path.module}/../ansible/inventory.yaml"
}