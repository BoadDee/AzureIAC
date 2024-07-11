@description('Optional. The location to deploy resources to.')
param location string = resourceGroup().location

@description('Required. The name of the Virtual Network to create.')
param virtualNetworkName string

@description('Required. The name of the manged identity to create.')
param managedIdentityName string

var addressPrefix = '10.0.0.0/16'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'defaultSubnet'
        properties: {
          addressPrefix: cidrSubnet(addressPrefix, 16, 0)
          serviceEndpoints: [
            {
              service: 'Microsoft.CognitiveServices'
            }
          ]
        }
      }
    ]
  }
}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: '${virtualNetworkName}.privatelink.azurewebsites.net'
  location: 'global'

  resource virtualNetworkLink 'virtualNetworkLinks@2020-06-01' = {
    name: '${virtualNetwork.name}-vnetlink'
    location: 'global'
    properties: {
      virtualNetwork: {
        id: virtualNetwork.id
      }
      registrationEnabled: false
    }
  }

} 

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
}

@description('The resource ID of the created Virtual Network Subnet')
output subnetReourceId string = virtualNetwork.properties.subnets[0].id

@description('The resource ID of the created Managed Identity')
output managedIdentityResourceId string = managedIdentity.id

@description('The principal ID of the created Managed Identity')
output managedIdentityPrincipalId string = managedIdentity.properties.principalId

@description('The resource ID of the created Private DNS Zone')
output privateDnsZoneResourceId string = privateDnsZone.id
