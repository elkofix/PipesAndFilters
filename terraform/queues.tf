resource "azurerm_storage_queue" "grayscale_queue" {
  name                 = "grayscale-queue"
  storage_account_name = azurerm_storage_account.image_storage.name
}

resource "azurerm_storage_queue" "resize_queue" {
  name                 = "resize-queue"
  storage_account_name = azurerm_storage_account.image_storage.name
}

resource "azurerm_storage_queue" "upload_queue" {
  name                 = "upload-queue"
  storage_account_name = azurerm_storage_account.image_storage.name
}
