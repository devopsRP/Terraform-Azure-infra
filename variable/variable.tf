#default variable
variable "rg_default_name" {
  description = "this variable for default variable for name"
  type        = string
  default     = "rg-default"
}

variable "rg_default_location" {
  description = "variable for default variable for location"
  type        = string
  default     = "central india"
}

#CLI variable

variable "rg_cli_name" {
  description = "variable for cli input rg name"
  type        = string
}

variable "rg_cli_location" {
  description = "variable for cli input rg location"

}

#tfvars variable
variable "rg_tfvars_name" {
  type        = string
  description = "tfvars variable"

}

variable "rg_tfvars_location" {
  type        = string
  description = "tfvars variable location"

}