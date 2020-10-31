variable "region" {
  type        = string
  default     = "tor1"
  description = "Region for cluster(s)"
}

variable "cluster_name" {
  type        = string
  default     = "mycluster"
  description = "Name of cluster"
}

variable "enable_consul_and_vault" {
  type        = bool
  default     = false
  description = "Enable consul and vault for the cluster"
}

variable digitalocean_api_token {
  type        = string
  description = "Digital Ocean API Token"
}
