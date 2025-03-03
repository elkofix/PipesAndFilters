resource "azurerm_service_plan" "function_plan" {
  name                = "image-processing-plan"
  resource_group_name = azurerm_resource_group.image_processing_rg.name
  location            = azurerm_resource_group.image_processing_rg.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "image_functions" {
  name                = "image-processing-functions"
  resource_group_name = azurerm_resource_group.image_processing_rg.name
  location            = azurerm_resource_group.image_processing_rg.location
  storage_account_name       = azurerm_storage_account.image_storage.name
  storage_account_access_key = azurerm_storage_account.image_storage.primary_access_key
  service_plan_id            = azurerm_service_plan.function_plan.id

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }

  app_settings = {
    "AzureWebJobsStorage"      = azurerm_storage_account.image_storage.primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME" = "python"
  }
}
