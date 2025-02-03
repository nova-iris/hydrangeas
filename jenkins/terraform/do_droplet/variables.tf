
# =============== Digital Ocean Variables =============== #
variable "do_token" {
  type        = string
  description = "DigitalOcean API Token"
  sensitive   = true
}

variable "ssh_key_name" {
  description = "Name of the SSH key resource in DigitalOcean"
  type        = string
  default     = "datalab-key"
}

variable "ssh_private_key" {
  description = "Private SSH key for DigitalOcean droplet access"
  type        = string
  default     = "~/.ssh/datalab-key"
}

variable "service_name" {
  type = string
  description = "Service name that will be deployed"
}

variable "droplet_image" {
  description = "Image name for droplet"
  type        = string
  default     = "ubuntu-24-04-x64"
}

variable "droplet_size" {
  description = "Size for droplet"
  type        = string
  default     = "s-8vcpu-16gb"
}

variable "droplet_region" {
  description = "Region for droplet"
  type        = string
  default     = "nyc1"
}

# List of available regions for validation
locals {
  available_regions = [
    "nyc1", "nyc3",    # New York
    "fra1",            # Frankfurt
    "lon1",            # London
    "sgp1",            # Singapore
    "sfo3",            # San Francisco
    "blr1",            # Bangalore
    "tor1"             # Toronto
  ]
}