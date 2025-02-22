module "k8s_vpc" {
  source = "../../../terraform_modules/vpc"
  name_prefix = var.service_name
  vpc_cidr = "10.1.0.0/16"
  availability_zones = [ "${var.region}a", "${var.region}b", "${var.region}c" ]
  public_subnet_cidrs = [ "10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24" ]
  private_subnet_cidrs = [ "10.1.11.0/24", "10.1.12.0/24", "10.1.13.0/24" ]
}

# Create ALB
module "node_lb" {
  source = "../../../terraform_modules/load_balancer/alb"
  name_prefix = var.service_name
  ec2_ids = concat(module.worker_nodes[*].instance_id, [module.controlplane.instance_id])
  vpc_id = module.k8s_vpc.vpc_id
  subnets = module.k8s_vpc.public_subnet_ids
}