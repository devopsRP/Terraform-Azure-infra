# Variable for list of Resource Group names
# Used with for_each after converting to set (toset)
# Each item in the list will create one Resource Group
variable "rg_names" {
  # type can be defined for better validation (recommended)
  # type = list(string)
}

# Variable for map of Resource Groups with locations
# Key   → Resource Group name
# Value → Azure location for that specific Resource Group
variable "rg_names_map" {
  # type can be defined for better structure (recommended)
  # type = map(string)
}

# Default location variable
# Used when creating resources with same region
variable "location" {
  default = "centralindia"   # Default Azure region
}