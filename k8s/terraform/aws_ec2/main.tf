module "controlplane" {
  source = "../../../terraform_modules/ec2"
  service_name = var.service_name
  instance_name = "control-node"

  ami = var.ami  
  instance_type = var.instance_type
  ssh_private_key = var.ssh_private_key

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

  ami = var.ami  
  instance_type = var.instance_type
  ssh_private_key = var.ssh_private_key
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
      ansible_user = var.instance_user
      ssh_private_key_file = var.ssh_private_key
    }
  )
  filename = "${path.module}/../../ansible/inventory.yaml"
}