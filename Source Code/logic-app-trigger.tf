resource "azurerm_resource_group" "example" {
  name     = "workflow-resources"
  location = "East US"
}

resource "azurerm_logic_app_workflow" "example" {
  name                = "workflow1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_logic_app_trigger_http_request" "example" {
  name         = "some-http-trigger"
  logic_app_id = azurerm_logic_app_workflow.example.id

  schema = <<SCHEMA
{
        {
        "schemaId": "Microsoft.Insights/activityLogs",
        "data": {
            "status": "Activated",
            "context": {
            "activityLog": {
                "authorization": {
                "action": "microsoft.insights/activityLogAlerts/write",
                "scope": "/subscriptions/…"
                },
                "channels": "Operation",
                "claims": "…",
                "caller": "logicappdemo@contoso.com",
                "correlationId": "91ad2bac-1afa-4932-a2ce-2f8efd6765a3",
                "description": "",
                "eventSource": "Administrative",
                "eventTimestamp": "2018-04-03T22:33:11.762469+00:00",
                "eventDataId": "ec74c4a2-d7ae-48c3-a4d0-2684a1611ca0",
                "level": "Informational",
                "operationName": "microsoft.insights/activityLogAlerts/write",
                "operationId": "61f59fc8-1442-4c74-9f5f-937392a9723c",
                "resourceId": "/subscriptions/…",
                "resourceGroupName": "LOGICAPP-DEMO",
                "resourceProviderName": "microsoft.insights",
                "status": "Succeeded",
                "subStatus": "",
                "subscriptionId": "…",
                "submissionTimestamp": "2018-04-03T22:33:36.1068742+00:00",
                "resourceType": "microsoft.insights/activityLogAlerts"
            }
            },
            "properties": {}
        }
    }
SCHEMA

}

resource "azurerm_logic_app_trigger_recurrence" "example" {
  name         = "run-every-day"
  logic_app_id = azurerm_logic_app_workflow.example.id
  frequency    = "Minutes"
  interval     = 10
}

