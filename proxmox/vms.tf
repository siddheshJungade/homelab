# Creates a proxmox_vm_qemu entity named blog_demo_test
resource "proxmox_vm_qemu" "test_vm" {
  
  count = 1 # Establishes how many instances will be created 
  name = "test-vm-${count.index + 2}" # count.index starts at 0
  target_node = var.proxmox_host

  # References our vars.tf file to plug in our template name
  clone = var.template_name
  # Creates a full clone, rather than linked clone 
  # https://pve.proxmox.com/wiki/VM_Templates_and_Clones
  full_clone  = "true"

  # VM Settings. `agent = 1` enables qemu-guest-agent
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

 disks {
        scsi {
            scsi0 {
                disk {
                    backup             = true
                    cache              = "none"
                    discard            = true
                    emulatessd         = true
                    iothread           = true
                    mbps_r_burst       = 0.0
                    mbps_r_concurrent  = 0.0
                    mbps_wr_burst      = 0.0
                    mbps_wr_concurrent = 0.0
                    replicate          = true
                    size               = 32
                    storage            = "local-lvm"
                }
            }
        }
    }

  network {
    model = "virtio"
    bridge = var.nic_name
    tag = var.vlan_num # This tag can be left off if you are not taking advantage of VLANs
  }


  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  #provisioner "local-exec" {
    # Provisioner commands can be run here.
    # We will use provisioner functionality to kick off ansible
    # playbooks in the future
    #command = "touch /home/tcude/test.txt"
  #}
}