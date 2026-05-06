# 1️⃣ Hardcoded (no variables used)
# Values are directly written in the code
# Not reusable and not recommended for real-world projects
resource "azurerm_resource_group" "rg_hard_coding" {
  name     = "hard-coded-rg"     # Fixed name
  location = "central india"     # Fixed location
}

# 2️⃣ Default Variable
# Values are defined in variables.tf with default values
# No need to pass input during runtime
resource "azurerm_resource_group" "rg_default" {
  name     = var.rg_default_name       # Comes from variable default
  location = var.rg_default_location   # Comes from variable default
}

# 3️⃣ CLI Input
# Values are passed at runtime using -var flag
# Example: terraform apply -var="rg_cli_name=rg1"
resource "azurerm_resource_group" "rg_cli" {
  name     = var.rg_cli_name           # Provided via CLI
  location = var.rg_cli_location       # Provided via CLI
}

# 4️⃣ tfvars File
# Values are stored in a separate .tfvars file
# Automatically loaded or passed using -var-file
resource "azurerm_resource_group" "rg_tfvars" {
  name     = var.rg_tfvars_name        # From tfvars file
  location = var.rg_tfvars_location    # From tfvars file
}