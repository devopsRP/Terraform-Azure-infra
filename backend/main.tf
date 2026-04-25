terraform {
  backend "azurerm" {

    resource_group_name  ="backend-rg"

    storage_account_name = "remotestorage88"
    container_name       = "tfstate"
    key = "terraform.tfstate"
    
  }

    required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.64.0"
    }
  }
}

provider "azurerm" {
    features {
      
    }
  
}

resource "azurerm_resource_group" "remote-rg" {
  name = "my_rg_remote"
  location = "central india"
  
}