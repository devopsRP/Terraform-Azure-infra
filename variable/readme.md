
---

# 📘 Terraform Azure Resource Group – Input Methods variable 

This project demonstrates **four different ways to provide input values in Terraform** using the Terraform with Azure Resource Groups.

---

## 🚀 Overview

We are creating Azure Resource Groups using different input techniques:

1. Hardcoded values
2. Default variable values
3. CLI input variables
4. `.tfvars` file

Each approach has different use cases, flexibility levels, and best practices.

---

## 📂 Project Structure

```
.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── README.md
```

---

# 1️⃣ Hardcoded Values

```hcl
resource "azurerm_resource_group" "rg_hard_coding" {
  name     = "hard-coded-rg"
  location = "central india"
}
```

### 🔍 Explanation

* Values are directly written inside the resource block.
* No variables are used.

### ✅ Advantages

* Simple and quick for testing.
* No dependency on external input.

### ❌ Disadvantages

* Not reusable.
* Not scalable.
* Hard to maintain in large projects.

### 📌 Best Use Case

* Learning Terraform
* Quick POC (Proof of Concept)

---

# 2️⃣ Default Variable Values

```hcl
resource "azurerm_resource_group" "rg_default" {
  name     = var.rg_default_name
  location = var.rg_default_location
}
```

### variables.tf

```hcl
variable "rg_default_name" {
  type    = string
  default = "default-rg"
}

variable "rg_default_location" {
  type    = string
  default = "central india"
}
```

### 🔍 Explanation

* Variables are defined with default values.
* If no value is passed, Terraform uses defaults.

### ✅ Advantages

* Reusable
* Cleaner code
* Flexible fallback mechanism

### ❌ Disadvantages

* Defaults may hide configuration mistakes

### 📌 Best Use Case

* Common configurations
* Base templates

---

# 3️⃣ CLI Input Variables

```hcl
resource "azurerm_resource_group" "rg_cli" {
  name     = var.rg_cli_name
  location = var.rg_cli_location
}
```

### variables.tf

```hcl
variable "rg_cli_name" {
  type = string
}

variable "rg_cli_location" {
  type = string
}
```

### 🖥️ How to Run

```bash
terraform apply \
  -var="rg_cli_name=cli-rg" \
  -var="rg_cli_location=central india"
```

### 🔍 Explanation

* Values are passed at runtime via CLI.

### ✅ Advantages

* Dynamic and flexible
* No hardcoding

### ❌ Disadvantages

* Not ideal for multiple variables
* Can become messy

### 📌 Best Use Case

* CI/CD pipelines
* Quick parameter changes

---

# 4️⃣ tfvars File

```hcl
resource "azurerm_resource_group" "rg_tfvars" {
  name     = var.rg_tfvars_name
  location = var.rg_tfvars_location
}
```

### variables.tf

```hcl
variable "rg_tfvars_name" {
  type = string
}

variable "rg_tfvars_location" {
  type = string
}
```

### terraform.tfvars

```hcl
rg_tfvars_name     = "tfvars-rg"
rg_tfvars_location = "central india"
```

### 🖥️ How to Run

```bash
terraform apply
```

or

```bash
terraform apply -var-file="terraform.tfvars"
```

### 🔍 Explanation

* Values are stored in a separate `.tfvars` file.

### ✅ Advantages

* Clean separation of config and values
* Best for team collaboration
* Easy environment management (dev/prod)

### ❌ Disadvantages

* Needs file management

### 📌 Best Use Case

* Production environments
* Multiple environments (dev, staging, prod)

---

# 🔥 Key Differences Summary

| Method      | Flexibility | Reusability | Best For   |
| ----------- | ----------- | ----------- | ---------- |
| Hardcoded   | ❌ Low       | ❌ No        | Testing    |
| Default Var | ⚠️ Medium   | ✅ Yes       | Templates  |
| CLI Input   | ✅ High      | ⚠️ Medium   | CI/CD      |
| tfvars File | ✅ High      | ✅ Yes       | Production |

---

# ⚠️ Important Points (Must Know)

* Always define variable **type** (e.g., `string`, `number`, `bool`)
* Use `.tfvars` for real-world projects
* Avoid hardcoding in production
* Use CLI for quick overrides
* Keep sensitive values in:

  * `.tfvars` (ignored via `.gitignore`)
  * or environment variables

---

# 🧠 Pro Tips

* Use naming conventions:

  ```
  <env>-<resource>-<location>
  ```

* Example:

  ```
  dev-rg-centralindia
  ```

* Use multiple tfvars:

  ```
  dev.tfvars
  prod.tfvars
  ```

---

# 🏁 Conclusion

Each method serves a different purpose:

* Learning → Hardcoded
* Default setup → Default variables
* Runtime flexibility → CLI
* Production → `.tfvars` ✅

---

If you want, I can also:

* convert this into **interview notes**
* or create **real-world Azure project structure with modules**
