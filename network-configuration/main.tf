data "terraform_remote_state" "base_state" {
  backend = "azure"

  config {
    storage_account_name = "${var.name}${var.env}${var.location}"
    key                  = "base-configuration"
    container_name       = "${var.state_location}"
    resource_group_name  = "${var.name}_${var.env}_${var.location}"
  }
}

resource "azurerm_virtual_network" "vnet0" {
  name                = "net10.0.0.0_cidr16"
  address_space       = ["10.0.0.0/16"]
  location            = "${lookup(var.locations, var.location)}"
  resource_group_name = "${data.terraform_remote_state.base_state.rg_name}"

  tags {
    environment = "${var.env}"
    terraform   = "true"
  }
}

resource "azurerm_subnet" "subnet0" {
  name                 = "net10.0.0.0_cidr24"
  resource_group_name  = "${data.terraform_remote_state.base_state.rg_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet0.name}"

  address_prefix = "10.0.0.0/24"
}

output "vnet0_id" {
  value = "${azurerm_virtual_network.vnet0.id}"
}

output "subnet0_id" {
  value = "${azurerm_subnet.subnet0.id}"
}
