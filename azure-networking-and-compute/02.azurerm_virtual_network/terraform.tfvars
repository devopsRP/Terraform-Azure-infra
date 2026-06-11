resource_group = {
    rg1={
        rg_name="dev_rg"
        rg_location="centralindia"
    }

    rg2={
        rg_name="prod_rg"
        rg_location="eastus"
    }
}

vnet = {
    vnet1={
      v_name ="dev_vnet"
      
      rg="rg1"
      addspace =["10.0.0.0/16"]
    }
   vnet2 ={
    v_name ="prod_vnet"
    rg ="rg2"
    addspace =["172.16.0.0/16"]

    }
}