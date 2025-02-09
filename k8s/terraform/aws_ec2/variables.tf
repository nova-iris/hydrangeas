variable "region" {
  description = "AWS region"
}

variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret key"
}

variable "service_name" {
  type = string
  description = "Service name that will be deployed"
}

variable "ami" {
    type = string
    default = "ami-0df8c184d5f6ae949" # Amazon Linux 2023
}

variable "instance_user" {
  type = string
  description = "EC2 Instance default user"
  default = "ec2-user"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "ssh_private_key" {
  type = string
  description = "Path to private ssh key"
  default = "/home/iris/.ssh/aws-ec2"
}

variable "worker_node_count" {
  type = number
  description = "Number of worker nodes"
  default = 2
}