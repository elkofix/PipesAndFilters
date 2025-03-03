resource "azurerm_resource_group" "image_processing_rg" {
  name     = var.resource_group_name
  location = var.region
}
