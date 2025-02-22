module "jenkins_instance" {
  source = "../../../terraform_modules/ec2"
  service_name = var.service_name
  instance_name = var.service_name
  instance_type = var.instance_type

  ssh_private_key = var.ssh_private_key
  ami = var.ami  
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../templates/ansible_inventory.tftpl",
    {
      ip = module.jenkins_instance.public_ip
      service_name = var.service_name
      ansible_user = var.instance_user
      ssh_private_key_file = var.ssh_private_key
    }
  )
  filename = "${path.module}/../../ansible/inventory.yaml"
}