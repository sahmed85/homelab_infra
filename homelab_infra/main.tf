terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# proxmox server connection
provider "proxmox" {
    pm_api_url = "https://10.0.0.176:8006/api2/json"
    pm_user     = var.proxmox_user
    pm_password = var.proxmox_password
}

# compute server (rancher, TF, etc)
resource "proxmox_vm_qemu" "compute_server" {
  vmid = 100
  name        = "BreathofThunder"
  target_node = "homelab"
  iso         = "local:iso/ubuntu-server-22.04.3.iso"

  # Specifying the VM parameters
  os_type = "ubuntu"  # Ubuntu Server

  # Define the VM resources
  cores  = 2
  sockets = 1
  memory = 4096  # 4 GB

  # Disk configuration
  disk {
    storage = "local-lvm"  # Replace with your storage pool name
    size   = "60G"
    type   = "scsi"
  }

  # Network interface
  network {
    model  = "virtio"
    bridge = "vmbr0"  # Replace with your bridge name
    firewall = true
  }
}

# control plane and etcd server
resource "proxmox_vm_qemu" "vm_1" {
  vmid = 201
  name        = "homelab-k8s-cluster-vm1"
  target_node = "homelab"
  iso         = "local:iso/ubuntu-server-22.04.3.iso"

  # Specifying the VM parameters
  os_type = "ubuntu"  # Ubuntu Server

  # Define the VM resources
  cores  = 2
  sockets = 1
  memory = 2048  # 2 GB

  # Disk configuration
  disk {
    storage = "local-lvm"  # Replace with your storage pool name
    size   = "30G"
    type   = "scsi"
  }

  # Network interface
  network {
    model  = "virtio"
    bridge = "vmbr0"  # Replace with your bridge name
    firewall = true
  }
}

# worker node 1
resource "proxmox_vm_qemu" "vm_2" {
  vmid = 202
  name        = "homelab-k8s-cluster-vm2"
  target_node = "homelab"
  iso         = "local:iso/ubuntu-server-22.04.3.iso"

  # Specifying the VM parameters
  os_type = "ubuntu"  # Ubuntu Server

  # Define the VM resources
  cores  = 2
  sockets = 1
  memory = 2048  # 2 GB

  # Disk configuration
  disk {
    storage = "local-lvm"  # Replace with your storage pool name
    size   = "30G"
    type   = "scsi"
  }

  # Network interface
  network {
    model  = "virtio"
    bridge = "vmbr0"  # Replace with your bridge name
    firewall = true
  }
}

# worker node 2
resource "proxmox_vm_qemu" "vm_3" {
  vmid = 203
  name        = "homelab-k8s-cluster-vm3"
  target_node = "homelab"
  iso         = "local:iso/ubuntu-server-22.04.3.iso"

  # Specifying the VM parameters
  os_type = "ubuntu"  # Ubuntu Server

  # Define the VM resources
  cores  = 2
  sockets = 1
  memory = 2048  # 2 GB

  # Disk configuration
  disk {
    storage = "local-lvm"  # Replace with your storage pool name
    size   = "30G"
    type   = "scsi"
  }

  # Network interface
  network {
    model  = "virtio"
    bridge = "vmbr0"  # Replace with your bridge name
    firewall = true
  }
}

# Output the VM's ID
output "vm_id1" {
  value = proxmox_vm_qemu.vm_1.id
}

# Output the VM's ID
output "vm_id2" {
  value = proxmox_vm_qemu.vm_2.id
}

# Output the VM's ID
output "vm_id3" {
  value = proxmox_vm_qemu.vm_3.id
}
