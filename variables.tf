# Define config variables
variable "labelPrefix" {
  type        = string
  default     = "ha000070"
  description = "Your college username. This will form the beginning of various resource names."
}

variable "region" {
  type        = string
  default     = "Canada Central"
  description = "The region the resources will be created in."
}

variable "admin_username" {
  type        = string
  default     = "azureadmin"
  description = "The username for the local user account on the VM."
}