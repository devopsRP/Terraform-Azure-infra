module "rg_mod" {

  source = "./resourceGroup"

  rg_name = var.rg_name

  location = var.location

}


module "sta_mod" {

   depends_on = [ module.rg_mod ]
  source = "./storageAccount"

  sta_name = var.sta_name

  sta_location = var.sta_location
  
}