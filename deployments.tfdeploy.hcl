deployment "local_docker" {
  // You can override defaults here if you want different names/ports/images
  inputs = {
    network_name  = "stacks_net"
    volume_name   = "stacks_vol"
    container_name = "nginx-stacks"
    host_port     = 8080
    image         = "nginx:alpine"
  }

  // Create 3 workspaces, all using the agent pool
  workspace "network" {
    component      = component.network
    name           = "network"
    execution_mode = "agent"
    agent_pool_id  = "apool-tdD1VrRbPY5S4vKo"
    auto_apply     = true
  }

  workspace "volume" {
    component      = component.volume
    name           = "volume"
    execution_mode = "agent"
    agent_pool_id  = "apool-tdD1VrRbPY5S4vKo"
    auto_apply     = true
  }

  workspace "app" {
    component      = component.app
    name           = "app"
    execution_mode = "agent"
    agent_pool_id  = "apool-tdD1VrRbPY5S4vKo"
    auto_apply     = true

    depends_on = [
      workspace.network,
      workspace.volume
    ]
  }
}
