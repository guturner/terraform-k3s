# main.tf is the entrypoint to your Terraform module and provides the main configuration.
#   Also known as the "Root Module".

# Usage: Run via `terraform init` followed by `terraform apply`


terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

module "ha-k3s" {
  source = "github.com/aigisuk/terraform-digitalocean-ha-k3s"  # Calls the "ha-k3s" module from your root module.

  do_token             = var.do_token
  ssh_key_fingerprints = var.ssh_key_fingerprints
}