// deployments.tfdeploy.hcl

// Optional, keeps org/project DRY if you use CLI for plan/deploy
locals {
  tf_organization = "HUGS_NL"
  tf_project_name = "Default Project"
}

deployment "local_docker" {
  inputs = {
    network_name   = "stacks_net"
    volume_name    = "stacks_vol"
    container_name = "nginx-stacks"
    host_port      = 8080
    image          = "nginx:alpine"
  }
}
