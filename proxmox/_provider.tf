
terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc2"
    }
  }
}
provider "proxmox" {
    pm_api_url = var.api_url
    pm_api_token_id= var.token_id
    pm_api_token_secret= var.token_secret
    pm_tls_insecure = true
    pm_debug = true
    pm_log_enable = true
}