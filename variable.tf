variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "location" {
  description = "The location for the Key Vault."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group."
  type        = string
}

variable "sku_name" {
  description = "The SKU for the Key Vault (Standard or Premium)."
  type        = string
  default     = "standard"
}

variable "tenant_id" {
  description = "The tenant ID for the Key Vault."
  type        = string
}

variable "soft_delete_enabled" {
  description = "Enable purge protection for the Key Vault."
  type        = bool
  default     = true
}

variable "purge_protection_enabled" {
  description = "Enable purge protection for the Key Vault."
  type        = bool
  default     = true
}

variable "network_bypass" {
  description = "Specifies which traffic can bypass the network rules (AzureServices or None)."
  type        = string
  default     = "AzureServices"
}

variable "default_network_action" {
  description = "Specifies the default action to take when no rules match."
  type        = string
  default     = "Deny"
}

variable "ip_rules" {
  description = "List of IP addresses allowed to access the Key Vault."
  type        = list(string)
  default     = []
}

variable "virtual_network_subnet_ids" {
  description = "List of subnet IDs to grant access to the Key Vault."
  type        = list(string)
  default     = []
}

variable "access_policies" {
  description = "Access policies for the Key Vault."
  type = map(object({
    tenant_id               = string
    object_id               = string
    secret_permissions      = list(string)
    key_permissions         = list(string)
    certificate_permissions = list(string)
  }))
}

variable "secrets" {
  description = "Key-value pairs of secrets to store in the Key Vault."
  type        = map(string)
  default     = {}
}

variable "enable_private_endpoint" {
  description = "Whether to enable a private endpoint for the Key Vault."
  type        = bool
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "The subnet ID for the private endpoint."
  type        = string
  default     = ""
}
