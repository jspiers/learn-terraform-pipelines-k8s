output "cluster" {
  value = digitalocean_kubernetes_cluster.engineering.name
}

output "version" {
  value = digitalocean_kubernetes_cluster.engineering.version
}

output "host" {
  value     = digitalocean_kubernetes_cluster.engineering.endpoint
  sensitive = true
}

output "token" {
  value = var.digitalocean_api_token
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = base64decode(digitalocean_kubernetes_cluster.engineering.kube_config[0].cluster_ca_certificate)
  sensitive = true
}

output "enable_consul_and_vault" {
  value = var.enable_consul_and_vault
}

output "kube_config" {
  value     = digitalocean_kubernetes_cluster.engineering.kube_config[0].raw_config
  sensitive = true
}
