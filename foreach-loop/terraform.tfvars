
# List of Resource Group names
# Used with for_each (after converting to set)
# Each value in the list will create one Resource Group
rg_names = ["rg1","rg2","rg3","rg4"]

# Map of Resource Groups with their respective locations
# Key   → Resource Group name
# Value → Azure region for that Resource Group
rg_names_map = {
  rg_map1 = "central india"   # RG name: rg_map1, location: central india
  rg_map2 = "eastus"          # RG name: rg_map2, location: eastus
  rg_map3 = "northeurope"          # RG name: rg_map3, location: northeurope
  rg_map4 = "westus"          # RG name: rg_map4, location: westus
}