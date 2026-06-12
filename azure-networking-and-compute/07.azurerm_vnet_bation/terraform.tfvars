resource_group = {
    rg1={
        rg_name="bastion_rg"
        rg_location="centralindia"
    }

}

virtual_network =  {
    vnet1={
        v_name="bastion_network"
        rg="rg1"
        add_space=["10.0.0.0/16"]

    }

}

subnet = {
    sub1={
        sub_name="AzureBastionSubnet"
        vnet="vnet1"
        add_pref=["10.0.1.0/24"]
    }

}

public_ip = {
    pip1={
        ip_name="pip_bastion"
        vnet="vnet1"
    }

}

bastion_host = {
    bastion1={
    bastion_name="bastion_network"
    vnet="vnet1"
    sub="sub1"
    ip="pip1"
    config_name="ip_config"
    }
}