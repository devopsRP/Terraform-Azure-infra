# 🚀 Terraform Azure VM Infrastructure (End-to-End Setup)

## 📌 Overview

This Terraform configuration provisions a complete Azure infrastructure including:

* Resource Group
* Virtual Network (VNet)
* Subnet
* Public IP
* Network Interface (NIC)
* Network Security Group (NSG)
* Linux Virtual Machine (VM)

👉 This setup enables secure VM deployment with internet access and controlled traffic using firewall rules.

---

# 🏗️ Architecture

```text
Resource Group
   ↓
Virtual Network (VNet)
   ↓
Subnet
   ↓
NSG (Firewall Rules)
   ↓
NIC (Private + Public IP)
   ↓
Virtual Machine (VM)
```

---

# 🔹 1. Resource Group

## 💡 Purpose

A logical container for all Azure resources.

## 🤔 Why used

* Organizes resources
* Enables easy cleanup (delete RG = delete all resources)
* Mandatory in Azure

---

# 🔹 2. Virtual Network (VNet)

## 💡 Purpose

Creates a private network in Azure.

## 🤔 Why used

* Isolates infrastructure
* Enables internal communication
* Required for subnet and VM

---

# 🔹 3. Subnet

## 💡 Purpose

Divides the VNet into smaller segments.

## 🤔 Why used

* Logical separation of workloads
* Enables applying security policies

---

# 🔹 4. Public IP

## 💡 Purpose

Provides internet-facing access.

## 🤔 Why used

* Required for SSH access
* Required to access web apps via browser

---

# 🔹 5. Network Interface (NIC)

## 💡 Purpose

Connects VM to network.

## 🤔 Why used

* Holds both:

  * Private IP (internal)
  * Public IP (external)

---

## 🔥 Key Concept

```text
VM → NIC → IP
```

👉 VM never directly owns IP
👉 NIC manages networking

---

# 🔹 6. Network Security Group (NSG)

## 💡 Purpose

Acts as a firewall.

## 🤔 Why used

* Controls inbound/outbound traffic
* Protects VM from unauthorized access

---

## 🔥 Rules Configured

### ✔ SSH (Port 22)

* Allows remote login to VM

### ✔ HTTP (Port 80)

* Allows web traffic via browser

---

# 🔹 7. NSG Association

## 💡 Purpose

Applies NSG rules to subnet.

## 🤔 Why used

* Ensures all resources inside subnet follow same security rules

---

# 🔹 8. Linux Virtual Machine

## 💡 Purpose

Creates compute instance.

---

## 🔑 Key Configuration

### ✔ VM Size

Defines CPU and RAM.

### ✔ Authentication

```hcl
admin_username
admin_password
```

👉 Enables SSH login

---

### ✔ OS Disk

Stores operating system.

---

### ✔ Image

Defines OS (Ubuntu Linux)

---

## ⚠️ Note

* Password authentication enabled (not secure for production)
* SSH key recommended

---

# 🌐 Traffic Flow

```text
Internet
   ↓
Public IP
   ↓
NIC
   ↓
NSG (Firewall rules)
   ↓
Subnet
   ↓
VM
```

---

# 📤 Output Block (Important)

## 🔹 Public IP

```hcl
output "public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}
```

### 💡 Purpose

* Displays public IP after deployment
* Used for SSH and browser access

---

## 🔹 Private IP

```hcl
output "private_ip" {
  value = azurerm_network_interface.network_interface.private_ip_address
}
```

### 💡 Purpose

* Shows internal IP
* Used for internal communication

---

## 🚀 Usage

```bash
terraform output public_ip
```

```bash
ssh rpdevops@<public_ip>
```

---

# 🔐 Security Considerations

⚠️ Current configuration:

* Uses password authentication
* Allows traffic from all IPs (`*`)

👉 Recommended improvements:

* Use SSH key authentication
* Restrict NSG rules to your IP

---

# 🎯 Key Learnings

* Resource Group = container
* VNet/Subnet = network design
* NIC = network bridge
* NSG = firewall
* Public IP = internet access
* VM = compute

---

# 🧠 Interview Summary

👉 **“This Terraform configuration provisions a complete Azure infrastructure where networking, security, and compute are integrated, with NIC acting as the bridge between VM and network, and NSG enforcing traffic control.”**

---


Happy Terraforming 🚀
