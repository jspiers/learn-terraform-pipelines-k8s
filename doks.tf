data "digitalocean_kubernetes_versions" "v1_18" {
  version_prefix = "1.18."
}

# Digital Ocean Managed Kubernetes cluster
resource "digitalocean_kubernetes_cluster" "engineering" {
  name   = var.cluster_name
  region = var.region

  # version = "1.18.10-do.0" # hardcoded version
  version      = data.digitalocean_kubernetes_versions.v1_18.latest_version
  auto_upgrade = true

  tags = ["learn-terraform-pipelines-k8s"] # tag for future reference

  # Default node pool (required)
  node_pool {
    name = "weak"

    # get available compute node options with 'doctl compute size list'
    size = "s-1vcpu-2gb"
    # node_count = var.enable_consul_and_vault ? 2 : 1
    auto_scale = true
    min_nodes  = 1
    max_nodes  = var.enable_consul_and_vault ? 3 : 1
    # tags = ["terraform"]
    # labels = {
    #   strength = "weak"
    # }
  }
}
