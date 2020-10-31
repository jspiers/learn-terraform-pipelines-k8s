output "cluster" {
  value = digitalocean_kubernetes_cluster.k8s.name
}

output "version" {
  value = digitalocean_kubernetes_cluster.k8s.version
}

output "host" {
  value     = digitalocean_kubernetes_cluster.k8s.endpoint
  sensitive = true
}

output "token" {
  value     = var.digitalocean_api_token
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = base64decode(digitalocean_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate)
  sensitive = true
}

output "enable_consul_and_vault" {
  value = var.enable_consul_and_vault
}

output "kube_config" {
  value     = digitalocean_kubernetes_cluster.k8s.kube_config[0].raw_config
  sensitive = true
}
