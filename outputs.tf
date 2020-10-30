output "cluster" {
  # value = google_container_cluster.engineering.name
  value = digitalocean_kubernetes_cluster.engineering.name
}

output "version" {
  value = digitalocean_kubernetes_cluster.engineering.version
}

output "host" {
  # value     = google_container_cluster.engineering.endpoint
  value     = digitalocean_kubernetes_cluster.engineering.endpoint
  sensitive = true
}

output "cluster_ca_certificate" {
  # value     = base64decode(google_container_cluster.engineering.master_auth.0.cluster_ca_certificate)
  value     = base64decode(digitalocean_kubernetes_cluster.engineering.kube_config[0].cluster_ca_certificate)
  sensitive = true
}

# output "username" {
#   value     = google_container_cluster.engineering.master_auth.0.username
#   sensitive = true
# }

# output "password" {
#   value     = google_container_cluster.engineering.master_auth.0.password
#   sensitive = true
# }

output "enable_consul_and_vault" {
  value = var.enable_consul_and_vault
}

output "kube_config" {
  # value =     data.template_file.kubeconfig.rendered
  value     = digitalocean_kubernetes_cluster.engineering.kube_config[0].raw_config
  sensitive = true
}
