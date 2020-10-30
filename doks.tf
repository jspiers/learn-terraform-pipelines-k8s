# data "google_compute_zones" "available" {}


# Digital Ocean Managed Kubernetes cluster
resource "digitalocean_kubernetes_cluster" "engineering" {
  name    = var.cluster_name
  region  = var.region
  # get available versions: "doctl kubernetes options versions"
  # version = "latest" # use latest available version instead of hardcoding
  version = "1.18.10-do.0"

  tags = ["learn-terraform-pipelines-k8s"] # tag for future reference

  # Default node pool (required)
  node_pool {
    name       = "weak"
    # get available compute node options with 'doctl compute size list'
    size       = "s-1vcpu-2gb"
    node_count = var.enable_consul_and_vault ? 3 : 1
    # auto_scale = true
    # min_nodes = var.weak_nodes[0]
    # max_nodes = var.weak_nodes[1]
    tags = ["terraform"]
    labels = {
      strength = "weak"
    }
  }
}

# resource "google_container_cluster" "engineering" {
#   name     = var.cluster_name
#   location = data.google_compute_zones.available.names.0

#   # We can't create a cluster with no node pool defined, but we want to only use
#   # separately managed node pools. So we create the smallest possible default
#   # node pool and immediately delete it.
#   remove_default_node_pool = true
#   initial_node_count       = 1

#   master_auth {
#     username = var.username
#     password = var.password

#     client_certificate_config {
#       issue_client_certificate = false
#     }
#   }

#   ip_allocation_policy {}
# }

# resource "google_container_node_pool" "engineering_preemptible_nodes" {
#   name     = "${var.cluster_name}-node-pool"
#   cluster  = google_container_cluster.engineering.name
#   location = data.google_compute_zones.available.names.0

#   node_count = var.enable_consul_and_vault ? 3 : 1

#   node_config {
#     preemptible  = true
#     # "n1-standard-1" # original machine type from demo code
#     # "f1-micro" doesn't work (too little memory)
#     # "g1-small" works but more expensive than e2-micro
#     machine_type = "e2-micro"

#     metadata = {
#       disable-legacy-endpoints = "true"
#     }

#     oauth_scopes = [
#       "https://www.googleapis.com/auth/logging.write",
#       "https://www.googleapis.com/auth/monitoring",
#     ]
#   }
# }

# data "template_file" "kubeconfig" {
#   template = file("${path.module}/kubeconfig-template.yaml")

#   vars = {
#     cluster_name    = google_container_cluster.engineering.name
#     user_name       = google_container_cluster.engineering.master_auth[0].username
#     user_password   = google_container_cluster.engineering.master_auth[0].password
#     endpoint        = google_container_cluster.engineering.endpoint
#     cluster_ca      = google_container_cluster.engineering.master_auth[0].cluster_ca_certificate
#     client_cert     = google_container_cluster.engineering.master_auth[0].client_certificate
#     client_cert_key = google_container_cluster.engineering.master_auth[0].client_key
#   }
# }
