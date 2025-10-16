// Global variables you can override per-deployment
variable "network_name" {
  type    = string
  default = "stacks_net"
}

variable "volume_name" {
  type    = string
  default = "stacks_vol"
}

variable "container_name" {
  type    = string
  default = "nginx-stacks"
}

variable "host_port" {
  type    = number
  default = 8080
}

variable "image" {
  type    = string
  default = "nginx:alpine"
}

// Components
component "network" {
  source = "./modules/docker_network"
  inputs = {
    name = var.network_name
  }
}

component "volume" {
  source = "./modules/docker_volume"
  inputs = {
    name = var.volume_name
  }
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
}
