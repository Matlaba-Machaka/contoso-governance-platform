variable "location" {
  type        = string
  default     = "westeurope"
  description = "The target Azure geographical region where all corporate governance resources will be provisioned."
}

variable "prefix" {
  type        = string
  default     = "contoso-v2"
  description = "A standard global prefix applied to resource names to enforce organizational naming conventions."

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.prefix)) && length(var.prefix) <= 12
    error_message = "The prefix must be lowercase, alphanumeric (hyphens allowed), and 12 characters or less."
  }
}

variable "monthly_budget_amount" {
  type        = number
  default     = 50
  description = "The maximum hard financial threshold allowed per month for this production resource group scope."
}

variable "alert_email_recipient" {
  type        = string
  default     = "soc-alerts@contoso.co.za"
  description = "The destination email address where real-time billing anomalies and security threshold breaches are routed."
}

variable "log_retention_days" {
  type        = number
  default     = 90
  description = "The data retention period (in days) for audit logs sent to the central Log Analytics Workspace."
}
