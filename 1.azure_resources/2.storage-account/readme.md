# 📦 Azure Storage Account with Terraform 

## 📌 Overview

This Terraform configuration creates an **Azure Storage Account**, which is a core service used for storing:

* Blobs (files, images, backups)
* File shares
* Queues (messaging)
* Tables (NoSQL data)

👉 Storage Account is the **foundation of data storage in Azure**.

---

## 🏗️ Terraform Resource

```hcl
resource "azurerm_storage_account" "sa_block_name" {
  resource_group_name      = azurerm_resource_group.rg_block_name.name
  name                     = "storageaccount07052026"
  location                 = "central india"
  account_replication_type = "LRS"
  account_tier             = "Standard"
}
```

---

# 🔍 Detailed Explanation

## 🔹 1. Resource Type

```hcl
azurerm_storage_account
```

👉 Represents an Azure Storage Account resource
👉 Managed via Azure Resource Manager (ARM)

---

## 🔹 2. Resource Group Reference

```hcl
resource_group_name = azurerm_resource_group.rg_block_name.name
```

### 💡 What it does

* Links storage account to an existing Resource Group

### 🤔 Why important

* Creates **implicit dependency**
* Ensures Resource Group is created first

---

## 🔹 3. Storage Account Name

```hcl
name = "storageaccount07052026"
```

### ⚠️ Rules

* Must be **globally unique**
* Only **lowercase letters & numbers**
* Length: **3–24 characters**

### 💡 Why important

* Used as DNS endpoint:

```text
https://storageaccount07052026.blob.core.windows.net
```

---

## 🔹 4. Location

```hcl
location = "central india"
```

### 💡 What it does

* Defines Azure region

### ⚠️ Important

✔ Recommended format:

```hcl
centralindia
```

---

## 🔹 5. Account Tier

```hcl
account_tier = "Standard"
```

### Options:

| Tier     | Use Case                      |
| -------- | ----------------------------- |
| Standard | Cost-effective, general usage |
| Premium  | High performance (SSD-backed) |

---

## 🔹 6. Replication Type

```hcl
account_replication_type = "LRS"
```

### Options:

| Type   | Description                         |
| ------ | ----------------------------------- |
| LRS    | Locally redundant (same datacenter) |
| ZRS    | Zone redundant                      |
| GRS    | Geo redundant                       |
| RA-GRS | Read-access geo redundant           |

### 💡 Why LRS?

* Cheapest option
* Suitable for dev/test

---

# 🔥 Storage Account Capabilities

Once created, it can provide:

* Blob Storage → object storage
* File Share → SMB file system
* Queue Storage → messaging system
* Table Storage → NoSQL database

---

# 🔐 Security Considerations

## ⚠️ Default behavior

* Public access may be enabled
* No network restrictions

## ✅ Best Practices

* Enable private endpoints
* Restrict network access
* Enable encryption (default in Azure)

---

# 🚀 Terraform Workflow

## 🔹 Initialize

```bash
terraform init
```

## 🔹 Plan

```bash
terraform plan
```

## 🔹 Apply

```bash
terraform apply
```

---

# 🎯 Output Usage (Optional)

```hcl
output "storage_account_name" {
  value = azurerm_storage_account.sa_block_name.name
}
```

👉 Useful for:

* Referencing in other resources
* Scripts / automation

---

# 🔄 Dependency Flow

```text
Resource Group → Storage Account
```

👉 Terraform automatically ensures correct order

---

# ⚠️ Common Mistakes

❌ Invalid location:

```hcl
"central india"
```

✔ Correct:

```hcl
"centralindia"
```

---

❌ Duplicate storage account name
✔ Must be globally unique

---

# 💡 Real-World Use Cases

* Terraform remote backend
* Application file storage
* Backup storage
* Data lake foundation

---

# 🧠 Interview Summary

👉 **“Azure Storage Account is a globally unique, scalable storage service that supports multiple data types, with configurable performance tiers and redundancy models.”**

---



---

Happy Terraforming 🚀
