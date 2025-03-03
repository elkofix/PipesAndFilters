resource "azurerm_storage_account" "image_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.image_processing_rg.name
  location                 = azurerm_resource_group.image_processing_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
