terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "michal-rg" {
  name     = "michal-resources"
  location = "West Europe"
  tags = {
    environment = "Terraform Azure"
  }
}

resource "azurerm_virtual_network" "michal-vnet" {
  name                = "michal-vnet"
  resource_group_name = azurerm_resource_group.michal-rg.name
  location            = azurerm_resource_group.michal-rg.location
  address_space       = ["10.10.0.0/16"]

  tags = {
    environment = "Terraform Azure"
  }
}

resource "azurerm_subnet" "michal-subnet" {
  name                 = "michal-subnet"
  resource_group_name  = azurerm_resource_group.michal-rg.name
  virtual_network_name = azurerm_virtual_network.michal-vnet.name
  address_prefixes     = ["10.10.10.0/24"]

}

resource "azurerm_network_security_group" "michal-nsg" {
  name = "michal-nsg"
  location = azurerm_resource_group.michal-rg.location
  resource_group_name = azurerm_resource_group.michal-rg.name

  tags = {
    environment = "Terraform Azure"
  }
}

resource "azurerm_network_security_rule" "michal-ns-rule" {
  name                        = "michal-ns-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.michal-rg.name
  network_security_group_name = azurerm_network_security_group.michal-nsg.name
}