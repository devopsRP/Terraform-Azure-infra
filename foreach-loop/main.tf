# Create multiple Resource Groups using a list
# 'for_each' iterates over each value in the list (converted to set)
resource "azurerm_resource_group" "resource_group_foreach" {

  # Convert list to set to ensure unique values
  for_each = toset(var.rg_names)

  # each.value represents each item in the list (RG name)
  name     = each.value

  # Same location applied to all resource groups
  location = var.location
}

# Create multiple Resource Groups using a map
# 'for_each' iterates over key-value pairs
resource "azurerm_resource_group" "resource_group_foreach_map" {

  # Directly iterate over map variable
  for_each = var.rg_names_map

  # each.key = Resource Group name
  name     = each.key

  # each.value = Location for that specific Resource Group
  location = each.value
}