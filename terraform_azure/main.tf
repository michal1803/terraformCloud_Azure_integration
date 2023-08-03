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