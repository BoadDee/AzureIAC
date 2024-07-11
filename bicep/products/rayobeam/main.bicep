
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
param resourceGroupName string = 'rg-${project}-${environment}-boad'
@description('Required. Namr of the network resource group.')
param networkResourceGroupName string = 'rg-${project}-network-${environment}-boad'
@description('Optional. vnet Resource Croup Name.')
param vnetResourceGroupName string = (environment == 'de') ? 'rg-network-dre' : ''
// @description('Required. Name of the monitoring resource group.')
// param monitoringResourceGroupname string = (environment != 'pd') ? 'rg-monitoring-testing-boad' : 'rg-monitoring-live-boad'
// @description('Required. Name of the log analytics workspace.')
// param logAnalyticsWorkspaceName string = (environment != 'pd') ? 'la-monitoring-testing-boad' : 'la-monitoring-live-boad'
// @description('Required. Name of the virtual network.')
param vnetName string =  (environment == 'de') ? 'vnet-dre-01' : ''
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
param functionAppAPI string = 'func-${project}-${environment}-boad'
param functionAppSubnetName string = 'snet-${project}-${environment}-boad'
param subnetAddressPrefix string = '10.27.67.32/28' 
param aspServicePlan string = 'asp-${project}-${environment}-boad'
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
@description('Optional. AD Groupid for reader group')
param adGroupReader string = '66faf7ca-1a8b-4e46-b261-3d93144741a2' //should be the group ID of the resource group (found in rg IAM (reader)//: (environment == 'te') ? '' : (environment == 'pd') ? 'Reader-PD' : ''
@description('Optional. AD Groupid for contributor group')
param adGroupContributor string = '2cf0cfb0-940e-4e40-ba08-3d64ace0b351'//should be the group ID of the resource group (found in rg IAM (contributor)//: (environment == 'te') ? '' : (environment == 'pd') ? 'Contributor-PD' : ''
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

var deRgRolesAssignments = [
  {
    roleDefinitionIdorName: 'Reader'
    description: 'Reader role for the resource group'
    principalIds: [
      adGroupReader
    ]
    principalType: 'Group'
  }
  {
    roleDefinitionIdorName: 'Contributor'
    description: 'Contributor role for the resource group'
    principalIds: [
      adGroupContributor
    ]
    principalType: 'Group'
  }
  // {
  //   roleDefinitionIdorName: 'Owner'
  //   description: 'Owner role for the resource group'
  //   principalIds: [
  //     adGroupOwner
  //   ]
  //   principalType: 'Group'
  // }
]

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

var deRoleAssignmentsKv = [
  {
    roleDefinitionIdorName: 'Key Vault Administrator'
    description: 'Key Vault Administrator role for the key vault'
    principalIds: [
      adGroupContributor
    ]
    principalType: 'ServicePrincipal'
  }
  {
    roleDefinitionIdorName: 'Key Vault Secrets Officer'
    description: 'Key Vault Secrets Officer role for the key vault'
    principalIds: [
      adGroupContributor
    ]
    principalType: 'ServicePrincipal'
  }
  // {
  //   roledefinitionIdornName: 'Key Vaults Secrets User'
  //   description: 'Key Vaults Secrets User role for the key vault'
  //   principalIds: [
  //     functionApp.outputs.sysAssignedPrincipalId // check later
  //   ]
  //   principalType: 'ServicePrincipal'
  // }

  // check other roles later
]

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
      pythonVersion: '3.10'
      linuxFxVersion: 'Python|3.10'
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'

      alwaysOn: true
      http20Enabled: true
    }
  }
dependsOn: [
  subnet_functionApp
]
}


