data "digitalocean_kubernetes_versions" "v1_18" {
  version_prefix = "1.18."
}

# Digital Ocean Managed Kubernetes cluster
resource "digitalocean_kubernetes_cluster" "k8s" {
  name   = var.cluster_name
  region = var.region

  # version = "1.18.10-do.0" # hardcoded version
  version      = data.digitalocean_kubernetes_versions.v1_18.latest_version
  auto_upgrade = true

  tags = ["terraform"] # tag for future reference

  # Default node pool (required)
  node_pool {
    name = "weak"

    # get available compute node options with 'doctl compute size list'
    size = "s-1vcpu-2gb"
    # node_count = var.enable_consul_and_vault ? 2 : 1
    auto_scale = true
    min_nodes  = 1
    max_nodes  = var.enable_consul_and_vault ? 2 : 1
    tags       = ["terraform"] # tag for future reference
    labels = {
      strength = "weak"
    }
  }
}

# Another node pool with more CPU/memory per node
resource "digitalocean_kubernetes_node_pool" "strong" {
  cluster_id = digitalocean_kubernetes_cluster.k8s.id
  name       = "strong"
  size       = "s-2vcpu-4gb" # bigger instances
  node_count = 1
  tags       = ["terraform"] # tag for future reference
  labels = {
    strength = "strong"
  }
}
