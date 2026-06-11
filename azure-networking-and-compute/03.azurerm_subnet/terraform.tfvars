resource_group = {
       rg1={
        rg_name="dev_rg"
        rg_location="centralindia"
       }
}

vnet = {
   vnet1={
     v_name="dev_vnet"
    rg="rg1"
    add_space=["10.0.0.0/16"]
   }

}

subnet = {
    sub1={
       sub_name="app_subnet"
        network="vnet1"
        address_pref = ["10.0.1.0/24"]

    }

    sub2={
        sub_name="web_subnet"
        network= "vnet1"
        address_pref = ["10.0.2.0/24"]
        }

    sub3={
        sub_name="db_subnet"
        network="vnet1"
        address_pref=["10.0.3.0/24"]
    }
   

}