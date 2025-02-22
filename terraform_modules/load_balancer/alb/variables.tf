
variable "ec2_ids" {
  type = list(string)
  description = "List of EC2 instances"
}

variable "name_prefix" {
  type = string
  description = "Load balancer name prefix" 
}

variable "public_az" {
  type = string
  description = "Availability Zone for Public subnet"
  default = "us-east-1a"
}

variable "vpc_id" {
  type = string
  description = "VPC ID for the LB"
}

variable "subnets" {
  type = list(string)
  description = "List of subnet CIDR for the Load Balancer"
}

# listener rules
variable "alb_listener_rules" {
  description = "List of listener rules for ALB"
  type = list(object({
    priority = number
    conditions = list(object({
      field  = string
      values = list(string)
    }))
    actions = list(object({
      type             = string
      target_group_arn = optional(string)
      redirect = optional(object({
        protocol    = string
        port        = string
        status_code = string
      }))
    }))
  }))
  default = []
}