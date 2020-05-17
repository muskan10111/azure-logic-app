resource "azurerm_resource_group" "example" {
  name     = "resourcegroup-01"
  location = "West Europe"
}

resource "azurerm_automation_account" "example" {
  name                = "automation-01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    name = "Basic"
  }

  tags = {
    environment = "development"
  }
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "workspace-01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_log_analytics_linked_service" "example" {
  resource_group_name = azurerm_resource_group.example.name
  workspace_name      = azurerm_log_analytics_workspace.example.name
  resource_id         = azurerm_automation_account.example.id
}
