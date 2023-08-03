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