
terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc2"
    }
  }
}


provider "proxmox" {
  pm_api_url = "http://192.168.0.139:8006/api2/json"
  pm_debug = true
  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
    pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}