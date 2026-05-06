# 🌐 Azure VNet, Subnet & CIDR 

## 📌 Overview

 three core networking concepts:

* **VNet (Virtual Network)** → Full network boundary
* **Subnet** → Segmentation of VNet
* **CIDR** → Defines IP range and size

👉 Together, they form the **foundation of Azure networking**.

---

## 🏗️ Terraform Code

```hcl id="combined_code"
resource "azurerm_virtual_network" "vnet_block" {
  name                = "my_vnet"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location
  address_space       = ["10.0.0.0/16"]   # CIDR for VNet
}

resource "azurerm_subnet" "subnet_block" {
  name                 = "my_subnet"
  resource_group_name  = azurerm_resource_group.rg_block.name
  virtual_network_name = azurerm_virtual_network.vnet_block.name
  address_prefixes     = ["10.0.1.0/24"]  # CIDR for Subnet
}
```

---

# 🔥 1. Virtual Network (VNet)

## 💡 What is VNet?

👉 A **private network in Azure** where your resources live.

---

## 🧠 Why we use VNet

* Isolation from internet
* Internal communication between resources
* Foundation for subnets

---

## 📦 Example

```text id="vnet_example"
10.0.0.0/16
```

👉 This is the **CIDR block for VNet**

---

# 🔥 2. Subnet

## 💡 What is Subnet?

👉 A **smaller network inside VNet**

---

## 🧠 Why we use Subnet

* Divide network into layers (web/app/db)
* Apply security rules (NSG)
* Better organization

---

## 📦 Example

```text id="subnet_example"
10.0.1.0/24
```

👉 This must be inside VNet range

---

# 🔥 3. CIDR (Core Concept)

## 💡 What is CIDR?

👉 CIDR = **IP Address + Prefix**

```text id="cidr_example"
10.0.0.0/16
```

---

## 🔹 Meaning

| Part     | Explanation     |
| -------- | --------------- |
| 10.0.0.0 | Network address |
| /16      | Network size    |

---

## 🔹 CIDR Size Formula

```text id="cidr_formula"
2^(32 - prefix)
```

---

## 🔹 Examples

| CIDR | IP Count |
| ---- | -------- |
| /24  | 256      |
| /23  | 512      |
| /16  | 65,536   |

---

# 🔥 How to Design CIDR (Step-by-Step)

## 🔹 Step 1: Estimate IP requirement

| Size     | Use    |
| -------- | ------ |
| 50–200   | small  |
| 500–1000 | medium |
| 10k+     | large  |

---

## 🔹 Step 2: Choose VNet CIDR

👉 Recommended:

```text id="cidr_vnet"
10.0.0.0/16
```

---

## 🔹 Step 3: Create Subnets

```text id="cidr_subnet"
10.0.1.0/24 → Web
10.0.2.0/24 → App
10.0.3.0/24 → DB
```

---

# ⚠️ Azure Reserved IPs

👉 Azure reserves 5 IPs per subnet:

```text id="reserved_ips"
.x.0   → Network
.x.1   → Gateway
.x.2   → DNS
.x.3   → Azure
.x.255 → Broadcast
```

👉 Usable:

```text id="usable_ips"
256 - 5 = 251
```

---

# 🔥 Relationship (Very Important)

```text id="relationship_flow"
VNet → Subnet → NIC → VM
```

---

# ❗ CIDR Rules

## ✅ Valid

```text id="valid_cidr"
VNet:   10.0.0.0/16
Subnet: 10.0.1.0/24
```

---

## ❌ Invalid

```text id="invalid_cidr"
Subnet outside VNet ❌
192.168.1.0/24
```

---

## ❌ Overlapping

```text id="overlap_cidr"
10.0.1.0/24
10.0.1.0/25 ❌
```

---

# 🏗️ Real-World Architecture

```text id="real_arch"
10.0.0.0/16 (VNet)
 ├── 10.0.1.0/24 → Web Tier
 ├── 10.0.2.0/24 → App Tier
 └── 10.0.3.0/24 → DB Tier
```

---

# 💡 Best Practices

* Use `/16` for VNet
* Use `/24` for subnets
* Avoid overlap
* Plan for future scaling
* Keep separate subnets for tiers

---

# 🎯 Interview Summary

👉 **“VNet defines the overall network, subnet divides it into smaller segments, and CIDR determines the size and range of these networks.”**

---

# 🚀 Final Takeaways

* VNet = full network
* Subnet = segmentation
* CIDR = size calculation
* Proper CIDR planning = scalable infra

---


Happy Networking 🚀
