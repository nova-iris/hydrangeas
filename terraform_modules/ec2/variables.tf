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

variable "vpc_id" {
  type = string
  description = "vpc_id"
  default = ""
}

variable "subnet_id" {
  type = string
  description = "Subnet ID associate with the instance"
  default = ""
}

variable "security_group_ingress" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    security_groups = optional(list(string), [])
  }))
  default = []
}

variable "security_group_egress" {
  description = "List of egress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
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