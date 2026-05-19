rg_resource = {
   dev_rg={
    name="dev_rg"
    location="centralindia"
   }
   stag_rg={
    name="stag_rg"
    location="eastus"
   }
   prod_rg={
    name="prod_rg"
    location="westus"
   }

}


storage_account = {
    dev={
            name = "storageaccount1011112222"
            rg_name = "dev_rg"
            location = "centralindia"
            account_tier = "Standard"
            account_replication_type = "LRS"
        }
    
    stag={
            name = "storageaccount102222"
            rg_name = "stag_rg"
            location = "eastus"
            account_tier = "Standard"
            account_replication_type = "LRS"
        }
    
    prod={
          name = "storageaccount103333"
            rg_name = "prod_rg"
            location = "westus"
            account_tier = "Standard"
            account_replication_type = "LRS"
        }
}