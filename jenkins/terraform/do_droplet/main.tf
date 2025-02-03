terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "ssh_key" {
  name       = "${var.ssh_key_name}-${uuid()}"
  public_key = file("${var.ssh_private_key}.pub")
}

# create all_in_one droplet
resource "digitalocean_droplet" "jenkins" {
  name   = "all-in-one"
  size   = var.droplet_size
  image  = var.droplet_image
  region = var.droplet_region
  ssh_keys = [digitalocean_ssh_key.ssh_key.id]

  tags = concat(
    ["managed-by-terraform"],
    [var.droplet_region]
  )
}

# generate inventory file for ansible 
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../templates/ansible_inventory.tftpl",
    {
      ip = digitalocean_droplet.jenkins.ipv4_address
      service_name = var.service_name
      ansible_user = "root"
      ssh_private_key_file = var.ssh_private_key
    }
  )
  filename = "${path.module}/../../ansible/inventory.yaml"
}

output "jenkins_instance_ip" {
  value = digitalocean_droplet.jenkins.ipv4_address
}
