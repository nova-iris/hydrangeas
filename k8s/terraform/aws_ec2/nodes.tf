module "controlplane" {
  source = "../../../terraform_modules/ec2"
  service_name = var.service_name
  instance_name = "control-node"

  ami = var.ami  
  instance_type = var.instance_type
  ssh_private_key = var.ssh_private_key
  vpc_id = module.k8s_vpc.vpc_id
  subnet_id = module.k8s_vpc.public_subnet_ids[0]

  security_group_ingress = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] #TODO: Restrict SSH access
    }
  ]

  security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

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
  vpc_id = module.k8s_vpc.vpc_id
  subnet_id = module.k8s_vpc.public_subnet_ids[1]

  security_group_ingress = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] #TODO: Restrict SSH access
    }
  ]

  security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Name: "${var.service_name}-worker-node-${count.index}"
    ManagedBy: "Terraform"
  }
}
