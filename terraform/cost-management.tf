resource "azurerm_consumption_budget_resource_group" "budget" {
  name              = "bg-${var.prefix}-monthly"
  resource_group_id = azurerm_resource_group.gov_core.id
  amount            = var.monthly_budget_amount
  time_grain        = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00Z", timestamp())
  }

  notification {
    enabled   = true
    threshold = 80
    operator  = "GreaterThanOrEqualTo"
    contact_emails = [var.alert_email_recipient]
  }

  notification {
    enabled   = true
    threshold = 100
    operator  = "GreaterThanOrEqualTo"
    contact_emails = [var.alert_email_recipient]
  }
}
