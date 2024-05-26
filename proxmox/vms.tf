# Creates a proxmox_vm_qemu entity named blog_demo_test
resource "proxmox_vm_qemu" "k8s-controler-vm" {
    target_node = var.proxmox_host
    name = "${terraform.workspace}-controller-vm-${count.index + 1}" # count.index starts at 0
    desc = "Server Production 1, Main Application Server, Ubuntu LTS"
    count = 1 # Establishes how many instances will be created 
    os_type = "cloud-init"
    onboot = true
    # References our vars.tf file to plug in our template name
    clone = var.template_name
    full_clone  = false
    
    automatic_reboot = true
    # VM Settings. `agent = 1` enables qemu-guest-agent
    agent = 0
    cores = 2
    sockets = 2
    numa=true
    cpu = "host"
    memory = 4048
    vcpus = 0
    scsihw = "virtio-scsi-single"
    bootdisk = "scsi0"
    boot = "order=scsi0;net0"
    # cloudinit_cdrom_storage = "local-lvm"
    disks {
            scsi {
                scsi0 {
                    disk {
                        size = 60
                        storage = "local-lvm"
                    }
                }
            }
        }

    # network {
    #     model = "e1000"
    #     bridge = var.nic_name
    #     tag = var.vlan_num # This tag can be left off if you are not taking advantage of VLANs
    # }

    lifecycle {
        ignore_changes = [
            vm_state
        ]
    }
    
    # Cloud Init Settings 
    ipconfig0 = "ip=192.168.0.139/24,gw=192.0.0.1"
    # ciuser = "ubuntu"
    # sshkey = "your ssh key"
}


resource "proxmox_vm_qemu" "k8s-worker-vm" {
    target_node = var.proxmox_host
    name = "${terraform.workspace}-worker-vm-${count.index + 1}" # count.index starts at 0
    desc = "Server Production 1, Main Application Server, Ubuntu LTS"
    count = 3 # Establishes how many instances will be created 
    os_type = "cloud-init"
    onboot = true
    # References our vars.tf file to plug in our template name
    clone = var.template_name
    full_clone  = false
    
    automatic_reboot = true
    # VM Settings. `agent = 1` enables qemu-guest-agent
    agent = 0
    cores = 2
    sockets = 2
    numa=true
    cpu = "host"
    memory = 4048
    vcpus = 0
    scsihw = "virtio-scsi-single"
    bootdisk = "scsi0"
    boot = "order=scsi0;net0"
    # cloudinit_cdrom_storage = "local-lvm"
    disks {
            scsi {
                scsi0 {
                    disk {
                        size = 60
                        storage = "local-lvm"
                    }
                }
            }
        }

    # network {
    #     model = "e1000"
    #     bridge = var.nic_name
    #     tag = var.vlan_num # This tag can be left off if you are not taking advantage of VLANs
    # }

    lifecycle {
        ignore_changes = [
            vm_state
        ]
    }
    
    # Cloud Init Settings 
    ipconfig0 = "ip=192.168.0.139/24,gw=192.0.0.1"
    # ciuser = "ubuntu"
    # sshkey = "your ssh key"
}