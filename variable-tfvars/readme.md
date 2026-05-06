# 📦 Terraform Variable Practice – Azure Resource Groups

## 📌 Overview

This project demonstrates how to use **all major Terraform variable input methods** by creating multiple Azure Resource Groups.
Each resource group is configured using a different way of passing variables.

---

## 🏗️ Resources Created

The following Azure Resource Groups are created:

| Resource                   | Variable Source                  |
| -------------------------- | -------------------------------- |
| resource_group_default     | Default value (variables.tf)     |
| resource_group_cli         | Environment variable (`TF_VAR_`) |
| resource_group_var         | CLI `-var`                       |
| resource_group_varfile     | CLI `-var-file`                  |
| resource_group_tfvars      | `terraform.tfvars`               |
| resource_group_auto_tfvars | `*.auto.tfvars`                  |

---

## 📁 Project Structure

```
.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── dev.tfvars
├── custom.auto.tfvars
```

---

## 🔧 Variables Explanation

### 1️⃣ Default Values

Defined inside `variables.tf`

```hcl
variable "rg_name_default" {
  default = "rg-default"
}
```

---

### 2️⃣ Environment Variables (CLI)

Set using:

```bash
export TF_VAR_rg_name_cli="rg-cli"
export TF_VAR_cli_location="centralindia"
```

---

### 3️⃣ CLI `-var`

Passed directly in command:

```bash
-var="rg_name_var=rg-var"
-var="location_var=centralindia"
```

---

### 4️⃣ `-var-file` (dev.tfvars)

```hcl
rg_name_varfile  = "rg-varfile"
location_varfile = "westus"
```

---

### 5️⃣ terraform.tfvars

Auto-loaded by Terraform:

```hcl
rg_name_tfvars  = "rg-tfvars"
location_tfvars = "eastus"
```

---

### 6️⃣ auto.tfvars

Also auto-loaded (higher priority):

```hcl
rg_name_auto_tfvars  = "rg-auto"
location_auto_tfvars = "centralus"
```

---

## ⚙️ How Terraform Uses Variables (Priority Order)

```
-var > TF_VAR_ > -var-file > auto.tfvars > terraform.tfvars > default
```

---

## 🚀 How to Run

### Step 1: Initialize Terraform

```bash
terraform init
```

---

### Step 2: Set Environment Variables

#### Linux / Mac

```bash
export TF_VAR_rg_name_cli="rg-cli"
export TF_VAR_cli_location="centralindia"
```

#### Windows (PowerShell)

```powershell
$env:TF_VAR_rg_name_cli="rg-cli"
$env:TF_VAR_cli_location="centralindia"
```

---

### Step 3: Plan

```bash
terraform plan \
  -var-file="dev.tfvars" \
  -var="rg_name_var=rg-var" \
  -var="location_var=centralindia"
```

---

### Step 4: Apply

```bash
terraform apply \
  -var-file="dev.tfvars" \
  -var="rg_name_var=rg-var" \
  -var="location_var=centralindia"
```

---

### Optional (Auto approve)

```bash
terraform apply -auto-approve \
  -var-file="dev.tfvars" \
  -var="rg_name_var=rg-var" \
  -var="location_var=centralindia"
```

---

## ✅ Expected Output

Terraform will create **6 Azure Resource Groups**:

* rg-default
* rg-cli
* rg-var
* rg-varfile
* rg-tfvars
* rg-auto

---

## ⚠️ Common Issues

### ❌ Variable Prompt Appears

Cause: Missing input
Fix: Ensure all variables are provided via CLI, tfvars, or ENV

---

### ❌ Invalid Syntax in CLI

Correct format:

```
-var="key=value"
```

---

## 💡 Key Learnings

* Terraform supports multiple ways to pass variables
* Variable precedence is critical in real projects
* Avoid interactive input in automation pipelines
* Use tfvars for environment-based configurations

---



Happy Learning Terraform 🚀
