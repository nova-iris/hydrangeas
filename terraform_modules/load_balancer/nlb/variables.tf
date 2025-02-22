
variable "ec2_ids" {
  type = list(string)
  description = "List of EC2 instances"
}

variable "name_prefix" {
  type = string
  description = "Load balancer name prefix" 
}

variable "vpc_id" {
  type = string
  description = "VPC ID for the LB"
}

variable "subnets" {
  type = list(string)
  description = "List of subnet CIDR for the Load Balancer"
}