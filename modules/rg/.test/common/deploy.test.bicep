
targetScope = 'subscription'

metadata name = 'Using large parameter set'
metadata description = 'This instance deploys the module with most of its features enabled.'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'rg-dre-cac'

@description('Optional. The location to deploy resources to.')
param location string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'rrgmax'

@description('Optional. Enable telemetry via GUID.')
param enableDefaultTelemetry bool = true


// ============ //
// Dependencies //
// ============ //

// General resources
// =================
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: {
    Environment: 'Non-Prod'
    Role: 'DeploymentValidation'
  }
  managedBy: 'Dre'
}

// ============== //
// Test Execution //
// ============== //

module testDeployment '../../deploy.bicep' = {
  name: '${uniqueString(deployment().name, location)}-test-${serviceShort}'
  params: {
    location: location
    enableDefaultTelemetry: enableDefaultTelemetry
    name: resourceGroupName
    lock: 'CanNotDelete'
      
    roleAssignments: [
      {
        roleDefinitionIdOrName: 'Owner'
        principalId: [

      ]
      principalType: 'Group'
      }

    ]

    tags: {
      'hidden-title': 'This is visible in the resource name'
      Environment: 'Non-Prod'
      Role: 'DeploymentValidation'
    }
  }
}
