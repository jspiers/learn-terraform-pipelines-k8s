terraform {
  backend "remote" {
    organization = "cusk"

    workspaces {
      name = "learn-terraform-pipelines-k8s"
    }
  }
}

provider "digitalocean" {
  version = "~> 2.0"
  token   = var.digitalocean_api_token
}