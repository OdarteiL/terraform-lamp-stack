# LAMP Stack Deployment on AWS with Terraform

## 🚀 Overview

This project provisions a secure, modular, production-grade **LAMP (Linux, Apache, MySQL, PHP)** stack on AWS using **Terraform**. The infrastructure is split across multiple modules and includes monitoring, cost-awareness, and a NAT-enabled private network for application security.

---

## 📦 Components

* **VPC** with public and private subnets across 2 Availability Zones
* **Bastion Host** for SSH access to private instances
* **Web/App Server** running Apache and PHP in a private subnet
* **MySQL DB Server** in a private subnet
* **Application Load Balancer (ALB)** for exposing the app to the internet
* **NAT Gateway** for secure outbound internet from private subnets
* **Security Groups** for tiered access control

---

## 🗂️ Terraform Module Structure

```
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
└── modules
    ├── network
    ├── security
    ├── bastion
    ├── web
    ├── db
    └── app
```

---

## 🧰 Tools & Services

* **AWS EC2** for compute
* **AWS VPC** for network segregation
* **AWS ALB** for load balancing
* **Terraform** for Infrastructure as Code
* **Ubuntu** for the base OS
* **Apache2**, **PHP**, and **MySQL** for the LAMP stack

---

## 🔐 Security Best Practices

* No public access to DB or App instances
* Bastion host with SSH access only
* Security Groups enforce strict, tiered access
* App connects to DB via private IP only

---

## 🌍 App Functionality

The deployed application is a simple **PHP page counter**:

* `index.php` increments a counter stored in a `counter.txt` file
* Accessible via the public ALB DNS name
* Demonstrates persistent state without a database

---

## ✅ Usage

### 1. Clone and Configure

```bash
git clone <repo>
cd lamp-stack-terraform
```

Update `terraform.tfvars` with your settings:

```hcl
region = "eu-west-1"
key_name = "general_keys.pem"
public_subnet_cidr = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
public_subnet_cidr_az2 = "10.0.3.0/24"
az = "eu-west-1a"
az2 = "eu-west-1b"
ami_id = "ami-01f23391a59163da9" # Ubuntu 22.04 in eu-west-1
```

### 2. Deploy Infrastructure

```bash
terraform init
terraform apply
```

### 3. Access the App

Get the ALB DNS name from Terraform output:

```bash
echo "http://$(terraform output -raw alb_dns_name)"
```

Open it in your browser to see:

```
<h1>Page Views: X</h1>
```

---

## 💰 Cost Optimization

* NAT Gateway only used for app provisioning
* Minimal `t2.micro` instances
* Easily destroy with `terraform destroy` to avoid charges

---

## 🧹 Teardown

When done, run:

```bash
terraform destroy
```

---

## 👤 Author

**Michael Odartei Lamptey**
DevOps | SRE | Cloud Infrastructure | GIS/Remote Sensing
