# Terraform Azure Backend (azurerm) – Complete Guide

This README provides a **complete explanation** of using an Azure backend in Terraform, including:

* Backend block (`azurerm`)
* Remote state management
* State locking (how & why)
* Setup steps in Azure
* Best practices for real-world usage

---

## 📌 What is a Backend?

In **Terraform**:

> A backend defines **where Terraform stores its state file (`terraform.tfstate`)**

---

## 🧠 What is Terraform State?

Terraform state file:

* Tracks all resources created
* Maps real infrastructure ↔ Terraform config
* Required for updates, changes, and deletes

---

## ❌ Problem with Local State

* Stored on one machine
* Not shared with team
* No locking
* Risk of overwrite or corruption

---

## ✅ Why Use Remote Backend?

Using remote backend (Azure):

* Centralized state storage
* Team collaboration
* Secure access
* Built-in state locking

---

## ☁️ Azure Backend (azurerm)

Terraform uses **Microsoft Azure** Blob Storage for remote state.

---

## 🔧 Backend Block Explained

| Argument               | Description                       |
| ---------------------- | --------------------------------- |
| `resource_group_name`  | Resource group containing storage |
| `storage_account_name` | Azure storage account             |
| `container_name`       | Blob container                    |
| `key`                  | State file name/path              |

---

## 📦 State File Location

```id="m0v6gq"
https://<storage-account>.blob.core.windows.net/<container>/<key>
```

Example:

```id="ey6rgh"
https://remotestorage88.blob.core.windows.net/tfstate/terraform.tfstate
```

---

## 🔐 State Locking in Azure

> Ensures only one user modifies infrastructure at a time

---

## ⚙️ How Locking Works (Azure)

Azure uses **Blob Lease mechanism**:

1. Terraform requests a **lease** on the state file
2. If lease acquired → operation continues
3. If already locked → Terraform fails
4. After completion → lease released

---

## ❗ Why State Locking is Critical

Without locking:

* Multiple users run `apply`
* State gets corrupted
* Infrastructure becomes inconsistent

With locking:

* Safe, sequential execution
* No conflicts

---

## 🧱 Required Azure Resources

Before using backend, create:

### 1️⃣ Resource Group

* Example: `backend-rg`

### 2️⃣ Storage Account

* Must be globally unique
* Example: `remotestorage88`

### 3️⃣ Blob Container

* Name: `tfstate`

---

## 🛠️ Setup Steps (Manual)

1. Go to Azure Portal
2. Create Resource Group
3. Create Storage Account
4. Open Storage Account → Containers
5. Create container:

   ```
   tfstate
   ```

---

## 🔑 Authentication

Terraform must authenticate with Azure using:

* Azure CLI (`az login`)
* Service Principal (recommended for CI/CD)

---

## 🚀 Initialize Backend

```bash id="k7hxkc"
terraform init
```

If backend changes:

```bash id="6hhp3l"
terraform init -reconfigure
```

---

## ⚙️ What Happens During Execution

When you run:

```bash id="m6p4hg"
terraform apply
```

Terraform will:

1. Acquire blob lease (lock)
2. Read remote state
3. Apply changes
4. Update state file
5. Release lock

---

## ⚠️ Common Errors

| Error                   | Cause                     |
| ----------------------- | ------------------------- |
| Backend not initialized | Forgot `terraform init`   |
| Storage not found       | Wrong names               |
| Lock error              | Previous run not released |
| Access denied           | Missing permissions       |

---

## 🔓 Force Unlock (if stuck)

```bash id="h92zti"
terraform force-unlock <LOCK_ID>
```

Use only if lock is stale.

---

## 🧠 Example Use Case

* Team of developers managing infrastructure
* Shared state in Azure
* Prevent conflicts using locking

---

## ✅ Best Practices

* Use separate keys per environment:

  ```
  dev/terraform.tfstate
  prod/terraform.tfstate
  ```
* Enable versioning (soft delete)
* Restrict access using IAM
* Never commit `.tfstate` to Git
* Use Service Principal for automation

---

## 🧩 Simple Analogy

* State file = shared Google Doc
* Azure Blob = cloud storage
* Lease = edit lock

Only one person edits at a time → no conflict

---

## 📚 Key Takeaways

* Backend stores Terraform state remotely
* Azure Blob Storage is used for state
* Locking is handled via blob lease
* Essential for team collaboration and safety

---
