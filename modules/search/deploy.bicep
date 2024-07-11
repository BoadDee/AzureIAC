metadata description = 'Creates an Azure AI Search instance.'
param name string
param location string = resourceGroup().location
param tags object = {}
param publicNetworkAccess string


param sku object = {
  name: 'standard'
}

param authOptions object = {}
param semanticSearch string = 'disabled'

param disableLocalAuth bool = false
// param disabledDataExfiltrationOptions array = []
// param encryptionWithCmk object = {
//   enforcement: 'Unspecified'
// }
// @allowed([
//   'default'
//   'highDensity'
// ])
// param hostingMode string = 'default'
// param networkRuleSet object = {
//   bypass: 'None'
//   ipRules: []
// }
// param partitionCount int = 1
// @allowed([
//   'enabled'
//   'disabled'
// ])

// param replicaCount int = 1
// @allowed([
//   'disabled'
//   'free'
//   'standard'
// ])


// var searchIdentityProvider = (sku.name == 'free') ? null : {
//   type: 'SystemAssigned'
// }

resource search 'Microsoft.Search/searchServices@2021-04-01-preview' = {
  name: name
  location: location
  tags: tags
  // The free tier does not support managed identity
  identity: {
    type: 'SystemAssigned'}
  properties: {
    authOptions: authOptions
    disableLocalAuth: disableLocalAuth
    disabledDataExfiltrationOptions: []
    encryptionWithCmk: {
      enforcement: 'Unspecified'
    }
    hostingMode: 'default'
    networkRuleSet: {
      bypass: 'None'
      ipRules: []}
    partitionCount: 1
    publicNetworkAccess: publicNetworkAccess
    replicaCount: 1
    semanticSearch: semanticSearch
  }
  sku: sku
}

output id string = search.id
output endpoint string = 'https://${name}.search.windows.net/'
output name string = search.name
