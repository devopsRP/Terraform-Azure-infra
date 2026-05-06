# 🔁 Terraform `for_each` –(List/Set & Map)

### Based on Code Structure (Azure Resource Groups)

---

## 📌 Overview

This project demonstrates how to use Terraform’s `for_each` with:

* ✅ **List (converted to Set using `toset`)**
* ✅ **Map (key-value pairs)**

It uses a clean folder structure:

```text
.
├── main.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
```

The goal is to create multiple Azure Resource Groups dynamically using different input types.

---

## 🏗️ Your Core Terraform Code

```hcl
resource "azurerm_resource_group" "resource_group_foreach" {
  for_each = toset(var.rg_names)

  name     = each.value
  location = var.location
}

resource "azurerm_resource_group" "resource_group_foreach_map" {
  for_each = var.rg_names_map

  name     = each.key
  location = each.value
}
```

---

# 📁 Folder Structure Explanation

## 🔹 `provider.tf`

```hcl
provider "azurerm" {
  features {}
}
```

👉 Defines Azure provider configuration.

---

## 🔹 `variables.tf`

```hcl
variable "rg_names" {
  type = list(string)
}

variable "rg_names_map" {
  type = map(string)
}

variable "location" {
  default = "centralindia"
}
```

👉 Defines input variables for list and map-based `for_each`.

---

## 🔹 `terraform.tfvars`

```hcl
rg_names = ["rg1", "rg2", "rg3"]

rg_names_map = {
  rgA = "centralindia"
  rgB = "eastus"
}
```

👉 Provides actual values for variables.

---

# 🔥 1. `for_each` with List (Converted to Set)

## 🔹 Code

```hcl
for_each = toset(var.rg_names)
```

---

## 🧠 Concept

Terraform does not reliably support `for_each` directly on lists (due to ordering issues).
So we convert list → set using:

```hcl
toset(var.rg_names)
```

👉 Set ensures:

* Unique values only
* Order does not matter

---

## ⚙️ How It Works

Input:

```hcl
["rg1", "rg2", "rg3"]
```

Terraform internally creates:

```text
resource_group_foreach["rg1"]
resource_group_foreach["rg2"]
resource_group_foreach["rg3"]
```

---

## 🎯 Behavior

* `each.value` → `"rg1"`, `"rg2"`, `"rg3"`
* Location → same (`var.location`)

---

## ⚠️ Limitations

* All resources share same location
* Duplicate values removed silently
* Not suitable for complex configurations

---

# 🔥 2. `for_each` with Map

## 🔹 Code

```hcl
for_each = var.rg_names_map
```

---

## 🧠 Concept

Map is a **key-value pair structure**:

```hcl
{
  rgA = "centralindia"
  rgB = "eastus"
}
```

---

## ⚙️ How It Works

Terraform creates:

```text
resource_group_foreach_map["rgA"]
resource_group_foreach_map["rgB"]
```

---

## 🎯 Behavior

* `each.key` → resource name (`rgA`, `rgB`)
* `each.value` → location (`centralindia`, `eastus`)

---

## ✅ Advantages

* Each resource can have different configuration
* More flexible and scalable
* Preferred in real-world scenarios

---

# ⚖️ List vs Map – Detailed Comparison

| Feature            | List (`toset`)   | Map         |
| ------------------ | ---------------- | ----------- |
| Data Structure     | Simple list      | Key-value   |
| Resource Name      | each.value       | each.key    |
| Location           | Same             | Different   |
| Flexibility        | Low              | High        |
| Duplicate Handling | Removed silently | Not allowed |
| Real-world Use     | Limited          | Preferred   |

---

# 🔄 Internal Working of `for_each`

Terraform tracks resources using **keys**, not indexes.

Example:

```hcl
for_each = toset(["rg1","rg2"])
```

Creates:

```text
rg["rg1"]
rg["rg2"]
```

👉 If you remove `"rg1"`, only that resource is destroyed
👉 Others remain unchanged

---

# ⚠️ Common Mistakes

## ❌ Using list directly

```hcl
for_each = var.rg_names   # ❌
```

## ✅ Correct

```hcl
for_each = toset(var.rg_names)
```

---

## ❌ Duplicate values

```hcl
["rg1","rg1"]
```

👉 Set removes duplicates → unexpected results

---

## ❌ Confusing key/value in map

Correct usage:

```hcl
name     = each.key
location = each.value
```

---

# 🚀 Execution Steps

## Step 1: Initialize

```bash
terraform init
```

---

## Step 2: Plan

```bash
terraform plan
```

---

## Step 3: Apply

```bash
terraform apply
```

---

## Optional (auto approve)

```bash
terraform apply -auto-approve
```

---

# 🎯 Expected Output

### From List (`rg_names`)

* rg1 → centralindia
* rg2 → centralindia
* rg3 → centralindia

### From Map (`rg_names_map`)

* rgA → centralindia
* rgB → eastus

---

# 💡 Best Practices

* Prefer **map over list** for flexibility
* Use `toset()` when working with lists
* Avoid duplicate values
* Use meaningful keys for resource tracking
* Keep variables in `tfvars` for environment-specific configs

---

# 🧠 Interview Summary

👉 **for_each is used to create multiple resource instances from a collection (set or map) using unique keys instead of indexes, making it more stable and predictable than count.**

---


Happy Terraforming 🚀
