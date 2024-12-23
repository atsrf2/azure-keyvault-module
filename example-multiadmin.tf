module "key_vault" {
  source                = "./key_vault_module"
  key_vault_name        = "myServiceKeyVault"
  location              = "East US"
  resource_group_name   = "myResourceGroup"
  tenant_id             = "your-tenant-id"
  access_policies = {
    admin1 = {
      tenant_id               = "your-tenant-id"
      object_id               = "user-object-id"
      secret_permissions      = ["get", "list"]
      key_permissions         = ["get", "create"]
      certificate_permissions = ["get"]
    }
    admin2 = {
      tenant_id               = "your-tenant-id"
      object_id               = "admin-object-id-1"
      secret_permissions      = ["get", "list", "set"]
      key_permissions         = ["get", "create", "delete"]
      certificate_permissions = ["get", "create"]
    }
    admin3 = {
      tenant_id               = "your-tenant-id"
      object_id               = "admin-object-id-2"
      secret_permissions      = ["get", "list", "set"]
      key_permissions         = ["get", "create", "delete"]
      certificate_permissions = ["get", "create"]
    }
  }
  secrets = {
    secret1 = "value1"
    secret2 = "value2"
  }
  enable_private_endpoint = true
  private_endpoint_subnet_id = "/subscriptions/.../subnets/private-subnet"
}
