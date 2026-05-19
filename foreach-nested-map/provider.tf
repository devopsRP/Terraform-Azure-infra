terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {

  subscription_id = "59c19ff8-b613-4fa6-8935-91eda0f4d5d1"
  features {}
}