resource "azurerm_resource_group" "IaCBootcampBackendRG" {
  name     = var.rgName
  location = var.location
}

resource "azurerm_storage_account" "IaCBootcampStorageAccount" {
  name                = var.storage_account_name
  resource_group_name = azurerm_resource_group.IaCBootcampBackendRG.name
  location            = azurerm_resource_group.IaCBootcampBackendRG.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "IaCBootcampKeyVault" {
  name                = var.key_vault_name
  location            = azurerm_resource_group.IaCBootcampBackendRG.location
  resource_group_name = azurerm_resource_group.IaCBootcampBackendRG.name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
    ]
  }
}
