data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "vc-parent-resources" {
  for_each = var.resource_groups
  location = var.default_location
  name     = each.value.name
  tags     = each.value.tags
}

resource "azurerm_storage_account" "vc_storage_account" {
  depends_on               = [azurerm_resource_group.vc-parent-resources]
  name                     = var.storage_name
  resource_group_name      = var.resource_groups["vc-shared-rgp"].name
  location                 = var.default_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_blob_public_access = true
}

resource "azurerm_storage_container" "vc_storage_containers" {
  for_each                 = var.storage_containers
  name                     = each.value
  storage_account_name     = azurerm_storage_account.vc_storage_account.name
  container_access_type    = "private"
}

resource "azurerm_key_vault" "vc_key_vault" {
  depends_on                  = [azurerm_resource_group.vc-parent-resources]
  name                        = var.keyvault_name
  location                    = var.default_location
  resource_group_name         = var.resource_groups["vc-shared-rgp"].name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 14
  purge_protection_enabled    = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "Create",
      "Delete",
      "List"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "Delete",
      "List"
    ]

    storage_permissions = [
      "Get",
      "Set",
      "Delete",
      "List"
    ]
  }
}

resource "azurerm_container_registry" "demo_resource_acr" {
  depends_on          = [azurerm_resource_group.vc-parent-resources]
  name                = var.acr_name
  resource_group_name = var.resource_groups["vc-shared-rgp"].name
  location            = var.default_location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azuread_service_principal" "vc_service_principal" {
  application_id = "bbb94529-53a3-4be5-a069-7eaf2712b826" // Application Id of the VC Service
}

resource "azurerm_key_vault_access_policy" "vc_service_kvt_ap" {
  key_vault_id = azurerm_key_vault.vc_key_vault.id
  tenant_id    = var.tenant_id
  object_id    = azuread_service_principal.vc_service_principal.object_id

  key_permissions = [
    "List",
    "Create",
    "Get",
    "Sign"
  ]

  secret_permissions = [
    "List",
    "Set",
    "Get"
  ]
}

resource "azurerm_key_vault_access_policy" "vc_service_admin_kvt_ap" {
  key_vault_id = azurerm_key_vault.vc_key_vault.id
  tenant_id    = var.tenant_id
  object_id    = var.admin_object_id

  key_permissions = [
    "List",
    "Create",
    "Get",
    "Sign"
  ]

  secret_permissions = [
    "List",
    "Set",
    "Get"
  ]
}

resource "azurerm_role_assignment" "storage_container_role" {
  scope                = azurerm_storage_account.vc_storage_account.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.admin_object_id
}