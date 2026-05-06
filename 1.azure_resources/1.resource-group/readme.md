# 📦 Azure Resource Group with Terraform 

## 📌 Overview

This Terraform configuration creates an **Azure Resource Group**, which is the **foundation container** for all Azure resources.

👉 Every Azure resource (VM, Storage, Network, etc.) **must belong to a Resource Group**.

---

## 🏗️ Terraform Resource

```hcl id="rgcode01"
resource "azurerm_resource_group" "rg_block_name" {
  location = "central india"
  name     = "rg_name"
}
```

---

# 🔍 Detailed Explanation

## 🔹 1. Resource Type

```hcl id="rgtype01"
azurerm_resource_group
```

👉 Represents a Resource Group in Azure
👉 Managed using Azure Resource Manager (ARM)

---

## 🔹 2. Terraform Block Name

```hcl id="rgblock01"
"rg_block_name"
```

👉 Internal name used by Terraform
👉 Used for referencing:

```hcl id="rgref01"
azurerm_resource_group.rg_block_name.name
```

---

## 🔹 3. Name

```hcl id="rgname01"
name = "rg_name"
```

### 💡 What it does

* Defines the actual Resource Group name in Azure

### ⚠️ Rules

* Must be unique within a subscription
* Can include letters, numbers, hyphens

### 📌 Example

```text id="rgexample"
dev-rg
prod-rg
network-rg
```

---

## 🔹 4. Location

```hcl id="rglocation01"
location = "central india"
```

### 💡 What it does

* Defines Azure region for the Resource Group metadata

### ⚠️ Important

✔ Recommended format:

```hcl id="rglocation02"
"centralindia"
```

❌ Incorrect:

```hcl id="rglocation03"
"central india"
```

---

# 🧠 What is a Resource Group?

👉 A **logical container** that holds related Azure resources.

---

# 🔥 Why Resource Group is Important

## ✔ Organization

* Groups related resources together

## ✔ Lifecycle Management

* Delete RG → deletes all resources inside

## ✔ Access Control (RBAC)

* Apply permissions at RG level

## ✔ Billing & Cost Tracking

* Track costs per project/team

---

# 🏗️ Real-World Structure

```text id="rgstructure"
dev-rg
  ├── VM
  ├── Storage
  ├── VNet

prod-rg
  ├── App Service
  ├── Database
  ├── Load Balancer
```

---

# 🔄 Dependency Concept

```text id="rgflow"
Resource Group → All Azure Resources
```

👉 All resources must be created inside a Resource Group

---

# 🚀 Terraform Workflow

## 🔹 Initialize

```bash id="rginit"
terraform init
```

## 🔹 Plan

```bash id="rgplan"
terraform plan
```

## 🔹 Apply

```bash id="rgapply"
terraform apply
```

---

# 📤 Output Example (Optional)

```hcl id="rgoutput"
output "rg_name" {
  value = azurerm_resource_group.rg_block_name.name
}
```

👉 Helps retrieve Resource Group name after deployment

---

# ⚠️ Common Mistakes

## ❌ Wrong location format

```hcl id="rgmistake01"
"central india"
```

✔ Correct:

```hcl id="rgmistake02"
"centralindia"
```

---

## ❌ Hardcoded naming

👉 Not reusable

✔ Use variables:

```hcl id="rgvar01"
name = "${var.prefix}-rg"
```

---

# 💡 Best Practices

* Use naming conventions (env-based: dev, qa, prod)
* Use variables for flexibility
* Tag Resource Groups for cost tracking

---

# 🧠 Interview Summary

👉 **“A Resource Group is a logical container in Azure that organizes resources, enables lifecycle management, and provides access control at a group level.”**

---


Happy Terraforming 🚀
