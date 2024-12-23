provider "azurerm" {
  features {}
}

resource "azurerm_key_vault" "key_vault" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  sku_name                    = var.sku_name
  tenant_id                   = var.tenant_id
  purge_protection_enabled    = var.purge_protection_enabled

  network_acls {
    bypass                     = var.network_bypass
    default_action             = var.default_network_action
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }

}


resource "azurerm_key_vault_access_policy" "access_policies" {
  for_each                   = var.access_policies
  key_vault_id               = azurerm_key_vault.key_vault.id
  tenant_id                  = each.value.tenant_id
  object_id                  = each.value.object_id
  secret_permissions         = each.value.secret_permissions
  key_permissions            = each.value.key_permissions
  certificate_permissions    = each.value.certificate_permissions
}


resource "azurerm_key_vault_secret" "secrets" {
  for_each                    = var.secrets
  key_vault_id                = azurerm_key_vault.key_vault.id
  name                        = each.key
  value                       = each.value
}

resource "azurerm_private_endpoint" "private_endpoint" {
  count                     = var.enable_private_endpoint ? 1 : 0
  name                      = "${var.key_vault_name}-private-endpoint"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  subnet_id                 = var.private_endpoint_subnet_id

  private_service_connection {
    name                    = "privateConnection"
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    is_manual_connection    = false
  }
}
