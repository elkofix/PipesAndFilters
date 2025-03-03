output "function_app_name" {
  value = azurerm_linux_function_app.image_functions.name
}

output "storage_account_name" {
  value = azurerm_storage_account.image_storage.name
}
