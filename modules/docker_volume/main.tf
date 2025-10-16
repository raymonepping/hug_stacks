terraform {
  required_providers {
    docker = { source = "kreuzwerker/docker", version = "~> 3.0" }
  }
}

provider "docker" {}

resource "docker_volume" "this" {
  name = var.name
}

output "name" {
  value = docker_volume.this.name
}
