
//--------------------------------------------------------------------------
// Product Name:  
// Description:   
// This script can be used to deploy all the requried IaC resources 
// version:        1.0

//--------------------------------------------------------------------------
// Parameters
//--------------------------------------------------------------------------

targetScope = 'subscription' // subscription, resourceGroup, resource
@allowed([
  'de'
])
@description('Required. Environment')
param environment string
@description('Required. Project')
param project string
@description('Required. Location')
param location string

@description('Required. Name of resource Group.')
param resourceGroupName string = 'rg-${project}-${environment}-cac'
@description('Required. Namr of the network resource group.')
param networkResourceGroupName string = 'rg-${project}-network-${environment}-cac'
@description('Optional. vnet Resource Croup Name.')
param vnetResourceGroupName string = 'rg-network-dre'
// @description('Required. Name of the monitoring resource group.')
// param monitoringResourceGroupname string = (environment != 'pd') ? 'rg-monitoring-testing-boad' : 'rg-monitoring-live-boad'
// @description('Required. Name of the log analytics workspace.')
// param logAnalyticsWorkspaceName string = (environment != 'pd') ? 'la-monitoring-testing-boad' : 'la-monitoring-live-boad'
// @description('Required. Name of the virtual network.')
param vnetName string =  'vnet-dre-01'
// @description('Adf Name')
// param adfName string = 'adf-${project}-${environment}-boad'
// @description('Required. Name of key vault.')
// param keyVaultName string = 'kv-${project}-${environment}-boad'
// @description('Azure Sql Server Name')
// param sqlServerName string = 'sql-${project}-${environment}-boad'
// @description('Azure Sql Database Name')
// param sqlDatabaseName string = 'sqldb-${project}-${environment}-boad'
// @description('OpenAI Name')
// param openAIName string = '${project}-${environment}-boad'
// @description('Cognitive Service Name')
// param cognitiveServiceName string = 'cog-${project}-${environment}-boad'
// @description('Speech Service Name')
// param speechServiceName string = 'speech-${project}-${environment}-boad'
// @description('Document Intelligence Name')
// param documentIntelligenceName string = 'doc-${project}-${environment}-boad'
// @description('Redis Cache Name')
// param redisCacheName string = 'redis-${project}-${environment}-boad'
@description('Required. Name of function app API.')
param functionAppAPI string = 'func-${project}-${environment}-cac'
param functionAppAPI2 string = 'func01-${project}-${environment}-cac'
param functionAppSubnetName string = 'snet-${project}-${environment}-boad'
param subnetAddressPrefix string = '10.27.64.32/28' 
param aspServicePlan string = 'asp-${project}-${environment}-cac'
param sqlServerName string = 'sql-${project}-${environment}-cac'
param sqlDatabaseName string = 'sqldb-${project}-${environment}-cac'
param storageAccountName string = 'st${project}${environment}cac'

// param speechServiceName string = 'speech-${project}-${environment}-wus'
// param documentIntelligenceName string = 'doc-${project}-${environment}-boad'
// param skuName string = 'P1V3'
// @description('Optional. Subnet address prefix Name.')
// param subnetAddressPrefix string = (environment == 'de') ? '' : (environment == 'te') ? '' : (environment == 'pd') ? '' : ''
// @description('Optional. Subnet name requiredfor function App.')
// param functionAppSubnetName string = 'snet-${project}-${environment}-boad'
// @description('Required. Name of App Service Plan.')
// param appServicePlan string = 'asp-${project}-${environment}-boad'
// @description('Required. Name of storage account.')
// param storageAccountName string = 'st${project}${environment}boad'


//--------------------------------------------------------------------------
// Tags
//--------------------------------------------------------------------------
@description('Required tags of the resources.')
param APPID string = 'APPID'
param ApplicationName string = 'Application Name'
param ApplicationOwner string = 'Application Owner'
param EnvironmentType string = 'Environment Type'
param tags object = {
  '${APPID}': APPID
  '${ApplicationName}': 'Boad testing'
  '${ApplicationOwner}': 'Mofiyinfoluwa'
  '${EnvironmentType}': 'Testing'
}


//--------------------------------------------------------------------------
// Reader Group, Contributor Group and Developer Group
//--------------------------------------------------------------------------
// @description('Optional. AD Groupid for reader group')
// param adGroupReader string = '66faf7ca-1a8b-4e46-b261-3d93144741a2' //should be the group ID of the resource group (found in rg IAM (reader)//: (environment == 'te') ? '' : (environment == 'pd') ? 'Reader-PD' : ''
// @description('Optional. AD Groupid for contributor group')
// param adGroupContributor string = '2cf0cfb0-940e-4e40-ba08-3d64ace0b351'//should be the group ID of the resource group (found in rg IAM (contributor)//: (environment == 'te') ? '' : (environment == 'pd') ? 'Contributor-PD' : ''
// @description('Optional. AD Groupid for Owner group')
// param adGroupOwner string = (environment == 'de') ? '' //should be the group ID of the resource group (found in rg IAM (owner)//: (environment == 'te') ? '' : (environment == 'pd') ? 'Owner-PD' : ''
// @description('Optional. AD Groupid for developer group')
// param adGroupDeveloper string = '' //ad developer group id

//--------------------------------------------------------------------------
// Datbricks spn and paranmeters
//--------------------------------------------------------------------------
// @description('spn for Azure Databricks')
// param azureDatabricks string = '' // research for the ID used
// @description('Required. Name of the data bricks.')
// param databricksName string = 'dbs-${project}-${environment}-boad'
// @description('DBS public subnet Address Prefix ')
// param dbsPublicSubnetAddressPrefix string = (environment == 'de') ? '' : (environment == 'te') ? '' : (environment == 'pd') ? '' : ''
// @description('DBS private subnet Address Prefix ')
// param dbsPrivateSubnetAddressPrefix string = (environment == 'de') ? '' : (environment == 'te') ? '' : (environment == 'pd') ? '' : ''

//--------------------------------------------------------------------------
// Add spns for test and pd
//--------------------------------------------------------------------------
// param spnboad string = (environment != 'pd') ? '' : ''
// param spnBoads string = (environment != 'pd') ? '' : ''

//--------------------------------------------------------------------------
// Role Assignments
//--------------------------------------------------------------------------

// var deRgRolesAssignments = [
//   {
//     roleDefinitionIdorName: 'Reader'
//     description: 'Reader role for the resource group'
//     principalIds: [
//       adGroupReader
//     ]
//     principalType: 'Group'
//   }
//   {
//     roleDefinitionIdorName: 'Contributor'
//     description: 'Contributor role for the resource group'
//     principalIds: [
//       adGroupContributor
//     ]
//     principalType: 'Group'
//   }
  // {
  //   roleDefinitionIdorName: 'Owner'
  //   description: 'Owner role for the resource group'
  //   principalIds: [
  //     adGroupOwner
  //   ]
  //   principalType: 'Group'
  // }
// ]

// var teRgRolesAssignments = [
//   {
//     roleDefinitionIdorName: 'Reader'
//     description: 'Reader role for the resource group'
//     principalIds: [
//       adGroupReader
//     ]
//     principalType: 'Group'
//   }
//   {
//     roleDefinitionIdorName: 'Contributor'
//     description: 'Contributor role for the resource group'
//     principalIds: [
//       adGroupContributor
//     ]
//     principalType: 'Group'
//   }
//   // {
//   //   roleDefinitionIdorName: 'Owner'
//   //   description: 'Owner role for the resource group'
//   //   principalIds: [
//   //     adGroupOwner
//   //   ]
//   //   principalType: 'Group'
//   // }
// ]

// var pdRgRolesAssignments = [
//   {
//     roleDefinitionIdorName: 'Reader'
//     description: 'Reader role for the resource group'
//     principalIds: [
//       adGroupReader
//     ]
//     principalType: 'Group'
//   }
//   {
//     roleDefinitionIdorName: 'Contributor'
//     description: 'Contributor role for the resource group'
//     principalIds: [
//       adGroupContributor
//     ]
//     principalType: 'Group'
//   }
//   {
//     roleDefinitionIdorName: 'Owner'
//     description: 'Owner role for the resource group'
//     principalIds: [
//       adGroupOwner
//     ]
//     principalType: 'Group'
//   }
// ]

// var rolesAssignments = (environment == 'de') ? deRgRolesAssignments : '' //: pdRgRolesAssignments

// var deRoleAssignmentsKv = [
//   {
//     roleDefinitionIdorName: 'Key Vault Administrator'
//     description: 'Key Vault Administrator role for the key vault'
//     principalIds: [
//       adGroupContributor
//     ]
//     principalType: 'ServicePrincipal'
//   }
//   {
//     roleDefinitionIdorName: 'Key Vault Secrets Officer'
//     description: 'Key Vault Secrets Officer role for the key vault'
//     principalIds: [
//       adGroupContributor
//     ]
//     principalType: 'ServicePrincipal'
//   }
//   // {
//   //   roledefinitionIdornName: 'Key Vaults Secrets User'
//   //   description: 'Key Vaults Secrets User role for the key vault'
//   //   principalIds: [
//   //     functionApp.outputs.sysAssignedPrincipalId // check later
//   //   ]
//   //   principalType: 'ServicePrincipal'
//   // }

//   // check other roles later
// ]

// var kvRolesAssignments = (environment == 'de') ? deRoleAssignmentsKv : ''
// // var apimURL = (environment != 'pd') ? 'https://apim-testing-boad.azure-api.net' : 'https://apim-live-boad.azure-api.net'
// var repoType = 'FactoryGitHubConfiguration'
// var hostName = 'https://github.com'
// var accountName = 'BoadeAkintunde' // check later
// var repositoryName = 'boad-adf'
// var collaborationBranch = 'main'
// var rootFolder = './code'
// var disablePublish = false
var subscriptionId = resgroup.outputs.subscriptionId
var sqladmin = 'sqladmin'
var sqladminpassword = 'WDete12p#@ssw0rd'


var vnetResourceId = virtualNetwork.id

// Resource Group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: location
  tags: tags
} 

resource networkResourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: networkResourceGroupName
  location: location
  tags: tags
}

resource vnetResourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' existing = {
  name: vnetResourceGroupName
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-11-01' existing = {
  name: vnetName
  scope: vnetResourceGroup
}


// ----------------------------------------------------------
// resource creation and configuration
// ----------------------------------------------------------

module resgroup '../../../modules/resgroup/main.bicep' = {
  scope: subscription()
  name: resourceGroupName

  params: {
    location: location
    name: resourceGroupName
    tags: tags
  }
}

module network '../../../modules/resgroup/main.bicep' = {
  scope: subscription()
  name: networkResourceGroupName

  params: {
    location: location
    name: networkResourceGroupName
    tags: tags
  }
}

module asp '../../../modules/web/serverfarm/main.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-asp-api'

  params: {
    name: aspServicePlan
    sku: {
      name: 'P2V3'
    }
    kind : 'Linux'
    tags: tags
  }
}

module subnet_functionApp '../../../modules/network/subnet/main.bicep' = {
  scope: vnetResourceGroup
  name: '${uniqueString(deployment().name, location)}-subnet-fa'

  params: {
    name: functionAppSubnetName
    addressPrefix: subnetAddressPrefix
    virtualNetworkName: vnetName
    delegations: [
      {
        name: 'Microsoft.Web/serverFarms'
        properties: {
          serviceName: 'Microsoft.Web/serverFarms'
        }
      }
    ]
    
  }
}


module functionApp '../../../modules/web/site/main.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-asp-fa'
  params: {
    name: functionAppAPI
    kind: 'functionapp,linux'
    httpsOnly: true
    tags: tags
    serverFarmResourceId: '/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Web/serverFarms/${aspServicePlan}'
    virtualNetworkSubnetId: '${vnetResourceId}/subnets/${functionAppSubnetName}'
    siteConfig: {
      // pythonVersion: '3.10'
      linuxFxVersion: 'PYTHON|3.10'
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      alwaysOn: true
      http20Enabled: true
      disableLocalAuth: false
      publicNetworkAccess: 'Disabled'
    }
    // roleAssignments: [
    //   {
    //     roleDefinitionIdOrName: 'Contributor'
    //     principalId: adGroupContributor
    //     principalType: 'Group'
    //   }
    //   {
    //     roleDefinitionIdOrName: 'Contributor'
    //     principalId: adGroupReader
    //     principalType: 'Group'
    //   }
    // ]
  }
dependsOn: [
  subnet_functionApp
]
}


// module FA_PE '../../../modules/network/private-endpoint/main.bicep' = {
//   scope: networkResourceGroup
//   name: '${uniqueString(deployment().name, location)}-fa-pe'

//   params: {
//     groupIds: [
//       'sites'
//     ]
//     name: 'pe-${functionAppAPI}'
//     serviceResourceId: functionApp.outputs.resourceId
//     subnetResourceId: '${vnetResourceId}/subnets/${functionAppSubnetName}'
//     location: location
//     tags: tags
//     }
//     dependsOn: [
//       functionApp
//     ]
//   }

module functionApp2 '../../../modules/web/site/main.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-asp-fa2'
  params: {
    name: functionAppAPI2
    kind: 'functionapp,linux'
    httpsOnly: true
    tags: tags
    serverFarmResourceId: '/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Web/serverFarms/${aspServicePlan}'
    virtualNetworkSubnetId: '${vnetResourceId}/subnets/${functionAppSubnetName}'
    siteConfig: {
      // pythonVersion: '3.10'
      linuxFxVersion: 'PYTHON|3.10'
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      alwaysOn: true
      http20Enabled: true
      disableLocalAuth: false
      publicNetworkAccess: 'Disabled'
      
    }
    // roleAssignments: [
    //   {
    //     roleDefinitionIdOrName: 'Contributor'
    //     principalId: adGroupContributor
    //     principalType: 'Group'
    //   }
    //   {
    //     roleDefinitionIdOrName: 'Contributor'
    //     principalId: adGroupReader
    //     principalType: 'Group'
    //   }
    // ]
  }
dependsOn: [
  subnet_functionApp
]
}

module webApp '../../../modules/web/site/main.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-asp-web1'
  params: {
    name: 'web-${project}-${environment}-cac'
    kind: 'app,linux'
    httpsOnly: true
    tags: tags
    serverFarmResourceId: '/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Web/serverFarms/${aspServicePlan}'
    virtualNetworkSubnetId: '${vnetResourceId}/subnets/${functionAppSubnetName}'
    siteConfig: {
      pythonVersion: '3.10'
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      alwaysOn: true
      http20Enabled: true
      disableLocalAuth: false
      publicNetworkAccess: 'Disabled'
    }
    // roleAssignments: [
    //   {
    //     roleDefinitionIdOrName: 'Contributor'
    //     principalId: adGroupContributor
    //     principalType: 'Group'
    //   }
    //   {
    //     roleDefinitionIdOrName: 'Contributor'
    //     principalId: adGroupReader
    //     principalType: 'Group'
    //   }
    // ]
  }
}

module sqlServer '../../../modules/sql/server/main.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-sql-server'

  params: {
    name: sqlServerName
    location: location
    tags: tags
    administrators: {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: true
      administratorLogin: sqladmin
      administratorLoginPassword: sqladminpassword
      login: sqladmin
      principalType: 'User'
      sid: '1be1e152-c861-4f6d-9dcc-05566402f131'
      tenantId: subscription().tenantId
    }
    minimalTlsVersion: '1.2'
    
  }
}

module sqlFirewallRule '../../../modules/sql/server/firewall-rule/main.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-sql-server-firewall-rule'

  params: {
    name: 'AllowAllWindowsAzureIps'
    serverName: sqlServer.outputs.name
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

module serverSecurityAlertPolicy '../../../modules/sql/server/security-alert-policy/main.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-sql-server-security-alert-policy'

  params: {
    serverName: sqlServer.outputs.name
    name: 'Default'
    state: 'Enabled'
    emailAccountAdmins: true
  }
}

module sqlDatabase '../../../modules/sql/server/database/main.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-sql-db'

  params: {
    name: sqlDatabaseName
    location: location
    tags: tags
    skuTier: 'GeneralPurpose'
    skuFamily: 'Gen5'
    skuName: 'GP_Gen5_2'
    serverName: sqlServer.outputs.name
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    
  }
}

module storageAccount '../../../modules/storage/storage-account/main.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-st'

  params: {
    name: storageAccountName
    location: location
    tags: tags
    kind: 'StorageV2'
    skuName: 'Standard_LRS'
    
  }
}
// module speechservice '../../../modules/cog/account/main.bicep' = {
//   scope: resourceGroup
//   name: '${uniqueString(deployment().name, location)}-cog-speech'

//   params: {
//     name: speechServiceName
//     kind: 'SpeechServices'
//     location: 'westus'
//     tags: tags
//     sku: 'S0'
//     apiProperties: {
//       statisticsEnabled: false
//       }
//     enableTelemetry: true
//     disableLocalAuth: false 
//     publicNetworkAccess: 'Disabled'
//     restore: false
    
//       }
    
//     }

//   module docintelligenceservice '../../../modules/cog/account/main.bicep' = {
//     scope: resourceGroup
//     name: '${uniqueString(deployment().name, location)}-cog-doc'

//     params: {
//       name: documentIntelligenceName
//       kind: 'FormRecognizer'
//       location: 'westus'
//       tags: tags
//       sku: 'S0'
//       enableTelemetry: true
//       disableLocalAuth: false 
//       publicNetworkAccess: 'Disabled'
//       restore: false
      
//         }
      
//       }

  
 


