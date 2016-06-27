resource "azurerm_resource_group" "rg" {
  name     = "${var.name}_${var.env}_${var.location}"
  location = "${lookup(var.locations, var.location)}"

  tags {
    environment = "${var.env}"
    terraform   = "true"
  }
}

resource "azurerm_storage_account" "sa" {
  name                = "${var.name}${var.env}${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${lookup(var.locations, var.location)}"
  account_type        = "Standard_LRS"

  tags {
    environment = "${var.env}"
    terraform   = "true"
  }
}

resource "azurerm_storage_container" "sc_machine_image" {
  name                  = "machine-image"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  storage_account_name  = "${azurerm_storage_account.sa.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "sc_tf_state" {
  name                  = "terraform-state"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  storage_account_name  = "${azurerm_storage_account.sa.name}"
  container_access_type = "private"
}

output "rg_name" {
  value = "${azurerm_resource_group.rg.name}"
}

output "sa_name" {
  value = "${azurerm_storage_account.sa.name}"
}

output "sa_endpoint" {
  value = "${azurerm_storage_account.sa.primary_blob_endpoint}"
}

output "sc_machine_image" {
  value = "${azurerm_storage_container.sc_machine_image.name}"
}

output "sc_machine_image" {
  value = "${azurerm_storage_container.sc_tf_state.name}"
}
