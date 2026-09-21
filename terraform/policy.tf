resource "azurerm_policy_definition" "sku_guardrail" {
  name         = "restrict-compute-skus"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Contoso Guardrail: Allowed Virtual Machine SKUs"

  policy_rule = <<POLICY
  {
    "if": {
        "allOf": [
        { "field": "type", "equals": "Microsoft.Compute/virtualMachines" },
        { "field": "Microsoft.Compute/virtualMachines/sku.name", "notIn": ["Standard_B1s", "Standard_B2s"] }
      ]
    },
    "then": { "effect": "deny" }
  }
  POLICY
}

resource "azurerm_resource_group_policy_assignment" "enforce_sku" {
  name                 = "asgn-sku-guardrail"
  resource_group_id    = azurerm_resource_group.gov_core.id
  policy_definition_id = azurerm_policy_definition.sku_guardrail.id
  display_name         = "Enforce Approved Compute Options Only"
}