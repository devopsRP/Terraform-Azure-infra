resource_group = {
    rg1={
        rg_name="rg_peering"
        rg_location="centralindia"
    }
}

vnet = {
    vnet1={
        v_name= "network_1"
        v_location= "eastus"
        rg= "rg1"
        add_space= ["10.0.0.0/16"]
    }

    vnet2={
        v_name="network_2"
        v_location="westus"
        rg="rg1"
        add_space= ["10.1.0.0/16"]
    }
}

peering = {
    peering_1={
        peer_name="peer_1_to_2"
        rg="rg1"
        source_vnet="vnet1"
        target_vnet="vnet2"

    }

    peering_2={
        peer_name="peer_2_to_1"
        rg="rg1"
        source_vnet="vnet2"
        target_vnet="vnet1"

    }
}