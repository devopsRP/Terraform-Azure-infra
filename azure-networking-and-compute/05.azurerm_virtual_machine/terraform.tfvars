resource_group = {
    rg1={
        rg_name="vm_rg"
        rg_location="eastasia"
    }
}

vnet = {
    vnet1={
        name ="vnet_vm"
        rg ="rg1"
        add_space=["10.0.0.0/16"]
    }
}

subnet = {
    sub1={
        sub_name="subnet_vm"
        vnet ="vnet1"
        add_pref=["10.0.1.0/24"]
        
    }
}

nic = {
    nic1={
        nic_name="nic_vm"
         rg="rg1"
         sub="sub1"
         ipconfig_name  = "internal"
        
    }
}

virtual_machine = {
    vm1={
     vm_name   = "dev-vm"
     vnet       = "vnet1"
     disk_name ="disk1"
     nic       = "nic1"
     vm_size   = "Standard_D2s_v3"
    }
}