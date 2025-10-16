// components.tfcomponent.hcl

variable "network_name"  { type = string, default = "stacks_net" }
variable "volume_name"   { type = string, default = "stacks_vol" }
variable "container_name"{ type = string, default = "nginx-stacks" }
variable "host_port"     { type = number, default = 8080 }
variable "image"         { type = string, default = "nginx:alpine" }

required_providers {
  docker = {
    source  = "kreuzwerker/docker"
    version = "~> 3.0"
  }
}

provider "docker" {
  // Agent must have access to Docker:
  // mount /var/run/docker.sock or set DOCKER_HOST on the agent.
}

component "network" {
  source = "./modules/docker_network"
  inputs = { name = var.network_name }
  providers = { docker = provider.docker }
}

component "volume" {
  source = "./modules/docker_volume"
  inputs = { name = var.volume_name }
  providers = { docker = provider.docker }
}

component "app" {
  source = "./modules/docker_app"
  inputs = {
    name         = var.container_name
    host_port    = var.host_port
    image        = var.image
    network_name = components.network.outputs.name
    volume_name  = components.volume.outputs.name
  }
  providers = { docker = provider.docker }
}
