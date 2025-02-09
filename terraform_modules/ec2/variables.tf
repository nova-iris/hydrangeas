variable "service_name" {
  type = string
  description = "Service name that will be deployed"
}

variable "instance_name" {
  type = string
  description = "Instance name that will be deployed"
}

variable "ami" {
    type = string
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "ssh_private_key" {
  type = string
  description = "Path to private ssh key"
}

variable "tags" {
  description = "Tags to be applied to the instance"
  type        = map(string)
  default     = {}
}