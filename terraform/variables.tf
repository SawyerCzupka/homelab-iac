
variable "pm_api_url" {
  description = "API URL for the Proxmox server"
  type        = string
  default     = "https://192.168.0.5:8006/api2/json" # Update with your Proxmox API URL
}

variable "pm_node" {
  description = "Node name in the Proxmox cluster"
  type        = string
  default     = "pve" # Update with your node name
}

variable "pm_user" {
  description = "User for Proxmox authentication"
  type        = string
  default     = "root" # Update with your Proxmox user
}

# Sensitive data like passwords should not be hardcoded in variables.tf
# Instead, use Terraform environment variables or a secrets manager
variable "pm_password" {
  description = "Password for Proxmox authentication"
  type        = string
  default     = "VlexySexy12123434" # Do not set a default value for passwords
}


variable "num_k3s_control_nodes" {
  description = "Number of k3s control nodes"
  type = number
  default = 2
}

variable "num_k3s_worker_nodes" {
  description = "Number of k3s worker nodes"
  type = number
  default = 4
}

variable "template_vm_name" {
  default = "fedora39-cloudinit-template"
}