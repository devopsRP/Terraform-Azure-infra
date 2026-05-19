# Terraform Azure Infrastructure Deployment Using Nested Maps

---

# Overview

This Terraform project dynamically creates:

* Azure Resource Groups
* Azure Storage Accounts

using a **Nested Map Variable Structure** with `for_each`.

This approach is commonly used in **production-grade Terraform projects** because it makes infrastructure:

* Reusable
* Scalable
* Easy to manage
* Environment-based
* Less repetitive

---

# What is a Nested Map in Terraform?

A **Nested Map** means:

> A map containing another map inside it.

It helps store multiple grouped configurations in a clean structure.

---

# Simple Example of Nested Map

```hcl id="2aqn1n"
employee = {
  
  emp1 = {
    name = "Aman"
    city = "Delhi"
  }

  emp2 = {
    name = "Rahul"
    city = "Mumbai"
  }
}
```

---

# Understanding the Structure

## Outer Map

```hcl id="n89tl9"
emp1
emp2
```

These are unique keys.

---

## Inner Map

```hcl id="v5nnxp"
{
  name = "Aman"
  city = "Delhi"
}
```

This contains actual values.

---

# Why Do We Use Nested Maps?

Nested Maps are used because they:

| Benefit                   | Explanation                            |
| ------------------------- | -------------------------------------- |
| Reusability               | Same code works for multiple resources |
| Scalability               | Easy to add new environments           |
| Clean Code                | Avoids duplicate resource blocks       |
| Dynamic Infrastructure    | Resources created automatically        |
| Centralized Configuration | All values managed in one place        |
| Production Ready          | Industry-standard approach             |

---

# Real-Time Use Case

Instead of writing:

```hcl id="kmv7oe"
resource "azurerm_resource_group" "dev" {}
resource "azurerm_resource_group" "stag" {}
resource "azurerm_resource_group" "prod" {}
```

We use a single dynamic block with nested maps.

This reduces:

* Manual work
* Code duplication
* Maintenance effort

---

# Project Structure

```text id="6xur3n"
.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── provider.tf
└── README.md
```

---

# Understanding Your terraform.tfvars

---

# Resource Group Nested Map

```hcl id="0kvlqb"
rg_resource = {

   dev_rg = {
      name     = "dev_rg"
      location = "centralindia"
   }

   stag_rg = {
      name     = "stag_rg"
      location = "eastus"
   }

   prod_rg = {
      name     = "prod_rg"
      location = "westus"
   }
}
```

---

# Explanation

## Outer Keys

```hcl id="d1kt2e"
dev_rg
stag_rg
prod_rg
```

These represent environments.

---

## Inner Values

```hcl id="cspqxp"
{
  name     = "dev_rg"
  location = "centralindia"
}
```

These are configuration values.

---

# Storage Account Nested Map

```hcl id="yrk3x8"
storage_account = {

   dev = {
      name                     = "storageaccount1011112222"
      rg_name                  = "dev_rg"
      location                 = "centralindia"
      account_tier             = "Standard"
      account_replication_type = "LRS"
   }

   stag = {
      name                     = "storageaccount102222"
      rg_name                  = "stag_rg"
      location                 = "eastus"
      account_tier             = "Standard"
      account_replication_type = "LRS"
   }

   prod = {
      name                     = "storageaccount103333"
      rg_name                  = "prod_rg"
      location                 = "westus"
      account_tier             = "Standard"
      account_replication_type = "LRS"
   }
}
```

---

# Understanding the Logic

Each environment contains:

* Storage Account Name
* Resource Group
* Azure Region
* Storage Tier
* Replication Type

All configurations are grouped neatly.

---

# Understanding Your Terraform Code

---

# Resource Group Block

```hcl id="1p7g8x"
resource "azurerm_resource_group" "rg_block" {

  for_each = var.rg_resource

  name     = each.value.name
  location = each.value.location
}
```

---

# Step-by-Step Explanation

## for_each

```hcl id="s2fz7p"
for_each = var.rg_resource
```

Terraform loops through all entries inside `rg_resource`.

---

# First Iteration

```hcl id="8rlvdc"
dev_rg = {
  name     = "dev_rg"
  location = "centralindia"
}
```

Terraform creates:

```hcl id="y16d0y"
name     = "dev_rg"
location = "centralindia"
```

---

# Second Iteration

```hcl id="1p0eh3"
stag_rg = {
  name     = "stag_rg"
  location = "eastus"
}
```

Terraform creates another Resource Group.

---

# Third Iteration

```hcl id="3bd4jc"
prod_rg = {
  name     = "prod_rg"
  location = "westus"
}
```

Terraform creates Production Resource Group.

---

# Final Result

Terraform creates:

* dev_rg
* stag_rg
* prod_rg

using only ONE resource block.

---

# Storage Account Block

```hcl id="0hz1md"
resource "azurerm_storage_account" "sa_block" {

  depends_on = [ azurerm_resource_group.rg_block ]

  for_each = var.storage_account

  name                     = each.value.name
  resource_group_name      = each.value.rg_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
}
```

---

# Explanation

Terraform loops through all storage accounts dynamically.

---

# depends_on

```hcl id="dkp0xm"
depends_on = [ azurerm_resource_group.rg_block ]
```

Ensures:

* Resource Groups are created first
* Then Storage Accounts are created

This avoids dependency errors.

---

# each.value

Terraform accesses nested values using:

```hcl id="y75o3v"
each.value.name
each.value.location
```

Example:

```hcl id="6d3jry"
each.value.name
```

returns:

```text id="a4d7sv"
storageaccount1011112222
```

---

# How Terraform Reads Nested Maps

| Expression      | Meaning                       |
| --------------- | ----------------------------- |
| each.key        | Outer key                     |
| each.value      | Entire inner map              |
| each.value.name | Specific value from inner map |

---

# Example

For:

```hcl id="l35v1j"
dev = {
  name = "storageaccount1011112222"
}
```

| Expression      | Output                   |
| --------------- | ------------------------ |
| each.key        | dev                      |
| each.value      | Complete map             |
| each.value.name | storageaccount1011112222 |

---

# Advantages of Your Approach

| Feature             | Benefit                         |
| ------------------- | ------------------------------- |
| Dynamic Creation    | Automatically creates resources |
| Environment Based   | Supports Dev/Staging/Prod       |
| Reusable Code       | No repeated blocks              |
| Easy Scaling        | Add new environment easily      |
| Cleaner Terraform   | Professional structure          |
| Production Friendly | Real-world implementation       |

---

# How to Add New Environment

Simply add new entry:

```hcl id="azfb2s"
qa_rg = {
  name     = "qa_rg"
  location = "southindia"
}
```

No code changes required.

Terraform automatically creates it.

---

# Terraform Commands

## Initialize

```bash id="k91b9x"
terraform init
```

---

## Validate

```bash id="hn5w8o"
terraform validate
```

---

## Plan

```bash id="qax2iq"
terraform plan
```

---

## Apply

```bash id="gw7fc4"
terraform apply
```

---

## Destroy

```bash id="v2d3u0"
terraform destroy
```

---

# Best Practices Used

* Nested map variables
* Dynamic resource creation
* Environment-wise deployment
* Reusable code structure
* Dependency management
* Scalable Terraform design

---

# Important Terraform Concepts Used

| Concept     | Usage                        |
| ----------- | ---------------------------- |
| for_each    | Loop through resources       |
| Nested Maps | Store grouped configurations |
| each.key    | Access outer key             |
| each.value  | Access inner map             |
| depends_on  | Handle dependency            |
| tfvars      | Separate configuration       |

---

# Most Important Terraform Interview Questions

## Basic Questions

### 1. What is a Nested Map in Terraform?

A map inside another map used to store structured configuration data.

---

### 2. Why do we use Nested Maps?

To create scalable, reusable, and dynamic infrastructure.

---

### 3. Difference between count and for_each?

| count                        | for_each                  |
| ---------------------------- | ------------------------- |
| Uses index                   | Uses key-value            |
| Best for identical resources | Best for unique resources |
| Less readable                | More readable             |

---

### 4. What is each.key?

Returns outer map key.

Example:

```hcl id="sk5m03"
dev
stag
prod
```

---

### 5. What is each.value?

Returns complete inner map.

---

### 6. Why is for_each better for production?

Because resources are uniquely identified by keys.

---

### 7. What happens if key changes in for_each?

Terraform destroys old resource and creates new one.

---

### 8. What is depends_on?

Used to explicitly define dependency between resources.

---

### 9. Why use terraform.tfvars?

To separate configuration from code.

---

### 10. How does Terraform read Nested Maps?

Using:

```hcl id="3d4g5x"
each.value.variable_name
```

---

# Advanced Interview Questions

### 11. Can we use nested maps with modules?

Yes, commonly used in production modules.

---

### 12. Why are nested maps important in DevOps?

They support Infrastructure as Code scalability.

---

### 13. What are the limitations of nested maps?

* Complex structure for beginners
* Hard debugging if deeply nested

---

### 14. How do you access nested object values?

Example:

```hcl id="8jq2m8"
var.storage_account.dev.name
```

---

### 15. What type should be used for nested maps in variables.tf?

Example:

```hcl id="uy39hm"
type = map(object({
  name     = string
  location = string
}))
```

---

# Final Summary

This project demonstrates:

* Real-world Terraform coding standards
* Nested map implementation
* Dynamic Azure infrastructure deployment
* Production-ready Terraform practices
* Scalable Dev/Staging/Production setup

This is a very common approach used in:

* DevOps Projects
* Enterprise Infrastructure
* Cloud Automation
* Production Terraform Modules
