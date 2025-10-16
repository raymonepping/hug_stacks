terraform {
  required_providers {
    docker = { source = "kreuzwerker/docker", version = "~> 3.0" }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = var.image
  keep_locally = false
}

resource "docker_container" "app" {
  name  = var.name
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.host_port
  }

  networks_advanced {
    name = var.network_name
  }

  volumes {
    host_path      = null
    container_path = "/usr/share/nginx/html"
    read_only      = false
    volume_name    = var.volume_name
  }

  restart = "unless-stopped"
}

output "container_name" {
  value = docker_container.app.name
}
