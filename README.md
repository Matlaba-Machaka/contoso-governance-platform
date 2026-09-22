# Azure Enterprise Landing Zone & GitOps Engine

A highly secure **Azure Landing Zone** built using **Terraform** and deployed via a passwordless **GitHub Actions GitOps engine** utilizing **OpenID Connect (OIDC)**. 

This repository demonstrates modern Platform Engineering and DevSecOps principles—enforcing infrastructure immutability, automated cost control, compliance guardrails, and secure network isolation.

---

##  Architecture Design & Components

The infrastructure is modularised and broken down into isolated functional blocks:

| Module / Component | Technical Implementation Details | Enterprise Purpose |
| :--- | :--- | :--- |
| **`networking.tf`** | Hub & Spoke topology, dual Spokes (`10.1.0.0/16`, `10.2.0.0/16`), bidirectional VNet Peering | Network segregation & secure traffic routing |
| **`policy.tf`** | Custom Azure Policy definition with strict JSON compute rules (`deny` effect) | Hard compliance guardrail limiting VM SKUs to `B1s`/`B2s` |
| **`monitoring.tf`** | Central Log Analytics Workspace with **Microsoft Sentinel (SIEM)** extension | Centralised audit log aggregation & security analytics |
| **`cost-management.tf`** | `azurerm_consumption_budget` with dual notification thresholds (80% / 100%) | Hard budget cap preventing cloud spend anomalies |
| **`main.tf`** | Core resource group protected by an immutable `CanNotDelete` management lock | Blast-radius control and accidental deletion prevention |

---

##  The GitOps CI/CD Workflow

The GitHub Actions pipeline automates testing and deployment using secure, keyless Azure authentication:

| Stage | Process | Pipeline Action |
| :--- | :--- | :--- |
| **Step 1: 🧪 Validate** | Code Linting & Syntax Checks | Runs `terraform fmt -check` and `terraform validate` to ensure code quality. |
| **Step 2: 🛡️ DevSecOps** | Security Static Analysis (SAST) | Executes a Checkov scan to catch potential cloud misconfigurations early. |
| **Step 3: 🚀 Deploy** | Production Execution Engine | *Triggered strictly on merge to `main` branch.* Generates a secure OIDC token and executes `terraform apply -auto-approve`. |

## ⚙️ Local Development & Execution

To initialize the backend, validate code structure, and run lint checks locally:

```bash
# Initialize without remote backend state for safe syntax checks
cd terraform
terraform init -backend=false
terraform validate

# Enforce standard formatting styles recursively
terraform fmt -recursive
```

