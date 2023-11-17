
# Define Control Plane Nodes
resource "proxmox_vm_qemu" "k3s_control" {
  count             = var.num_k3s_control_nodes # Two control nodes
  name              = "k3s-control-${count.index}"
  target_node       = var.pm_node

  clone             = var.template_vm_name
  os_type           = "cloud-init"
  cores             = 4
  sockets           = 1
  cpu               = "host"
  memory            = 4096 # Adjusted memory for control nodes
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"

  disk {
    size            = "20G" # Increased disk size for control nodes
    type            = "scsi"
    storage         = "local-lvm"
  }

  network {
    model           = "virtio"
    bridge          = "vmbr0"
  }

  ipconfig0         = "ip=192.168.0.2${count.index}/24,gw=192.168.0.1"
  sshkeys = file("${var.ssh_key_file}")

  # Additional configurations...
}

# Define Worker Nodes
resource "proxmox_vm_qemu" "k3s_worker" {
  count             = var.num_k3s_worker_nodes # Four worker nodes
  name              = "k3s-worker-${count.index}"
  target_node       = var.pm_node

  clone             = var.template_vm_name
  os_type           = "cloud-init"
  cores             = 4
  sockets           = 1
  cpu               = "host"
  memory            = 8192 # Increased memory for worker nodes
  scsihw            = "virtio-scsi-pci"
  bootdisk          = "scsi0"

  disk {
    size            = "100G" # Increased disk size for worker nodes
    type            = "scsi"
    storage         = "local-lvm"
  }

   network {
    model           = "virtio"
    bridge          = "vmbr0"
  }

  # cloud-init settings
  # adjust the ip and gateway addresses as needed
  ipconfig0         = "ip=192.168.0.3${count.index}/24,gw=192.168.0.1"
  sshkeys = file("${var.ssh_key_file}")

  # Additional configurations...
}
