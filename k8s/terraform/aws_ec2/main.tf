module "controlplane" {
  source = "../../../terraform_modules/ec2"
  service_name = var.service_name
  instance_name = "control-node"
  ssh_private_key = var.ssh_private_key
  ami = var.ami  

  tags = {
    Name: "${var.service_name}-control-node"
    ManagedBy: "Terraform"
  }
}

module "worker_nodes" {
    count = var.worker_node_count

  source = "../../../terraform_modules/ec2"
  service_name = var.service_name
  instance_name = "worker-node-${count.index}"
  ssh_private_key = var.ssh_private_key
  ami = var.ami  
  tags = {
    Name: "${var.service_name}-worker-node-${count.index}"
    ManagedBy: "Terraform"
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible_inventory.tftpl",
    {
      master_ip = module.controlplane.public_ip
      worker_ips = module.worker_nodes[*].public_ip
      service_name = var.service_name
      ansible_user = "ec2-user"
      ssh_private_key_file = var.ssh_private_key
    }
  )
  filename = "${path.module}/../../ansible/inventory.yaml"
}