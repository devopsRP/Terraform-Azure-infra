# 1️⃣ Default Variable Input
# Values are defined with default in variables.tf
# No need to pass input during runtime
resource "azurerm_resource_group" "resource_group_default" {
  name     = var.rg_name_default        # Comes from default variable
  location = var.default_location      # Comes from default variable
}

# 2️⃣ CLI Input
# Values are passed using command line (-var)
# Example: terraform apply -var="rg_name_cli=rg1"
resource "azurerm_resource_group" "resource_group_cli" {
  name     = var.rg_name_cli            # Provided via CLI
  location = var.cli_location           # Provided via CLI
}

# 3️⃣ Variable File (.tf)
# Values defined in variables.tf without default
# Terraform will prompt user to enter values at runtime
resource "azurerm_resource_group" "resource_group_var" {
  name     = var.rg_name_var            # Entered manually during apply
  location = var.location_var           # Entered manually during apply
}

# 4️⃣ Variable File using -var-file
# Values stored in a custom tfvars file (e.g., dev.tfvars)
# Passed explicitly using CLI
# Example: terraform apply -var-file="dev.tfvars"
resource "azurerm_resource_group" "resource_group_varfile" {
  name     = var.rg_name_varfile        # From custom tfvars file
  location = var.location_varfile       # From custom tfvars file
}

# 5️⃣ terraform.tfvars (default tfvars file)
# Terraform automatically loads this file if present
resource "azurerm_resource_group" "resource_group_tfvars" {
  name     = var.rg_name_tfvars         # From terraform.tfvars
  location = var.location_tfvars        # From terraform.tfvars
}

# 6️⃣ auto.tfvars
# Automatically loaded by Terraform (no need to specify)
# Useful for environment-based configs
resource "azurerm_resource_group" "resource_group_auto_tfvars" {
  name     = var.rg_name_auto_tfvars    # From *.auto.tfvars
  location = var.location_auto_tfvars   # From *.auto.tfvars
}