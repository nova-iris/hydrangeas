variable "network_interface_id" {
  type = string
  default = "network_id_from_aws"
}

variable "ami" {
    type = string
    default = "ami-04b4f1a9cf54c11d0" # ubuntu server 24.04 LTS
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "ssh_public_file" {
  default = "/home/iris/.ssh/aws-ec2.pub"
}