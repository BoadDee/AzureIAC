@sys.description('Required. The IDs of the principals to assign the role to.')
param principalIds array

@sys.description('Required. The name of the role to assign. if it coannot be found you can specify the role definition ID instead.')
param roleDefinitionIdOrName string

@sys.description('Required. The resource ID of the resource to apply the role assignment to.')
param resourceId string

@sys.description('Optional. The principal type of the assigned principal ID')
@allowed([
    'User'
    'Group'
    'ServicePrincipal'
    'ForiegnGroup'
    'Device'
    ''
])

param principalType string = ''

@sys.description('Optional. The description of the role assignment.')
param description string = ''

@sys.description('Optional. The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container".')
param condition string = ''

@sys.description('Optional. Version of the condition.')
@allowed([
  '2.0'
])
param conditionVersion string = '2.0'

@sys.description('Optional. The Resource Id of the delegated managed identity resource.')
param delegatedManagedIdentityResourceId string = ''

var builtInRoleNames = {
  Contributor: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  'Cognitive Services Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b1b3b8e5-6e6e-4d1c-8f6a-5c7e4d5a7f4d')
  'Cognitive Services User': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b1b3b8e5-6e6e-4d1c-8f6a-5c7e4d5a7f4d')
  Owner: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8e3af657-a8ff-443c-a75c-2fe8c4bcb635')
  'Quota Request Operator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '0e5f05e5-9ab9-446b-b98d-1e2157c94125')
  Reader: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
  'Redis Cache Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d')
  'Resource Policy Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '36243c78-bf99-498c-9df9-86d9f8d28608')
  'Role Based Access Control Administrator (Preview)': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'f58310d9-a9f6-439a-9e8d-f62e7b41a168')
  'Tag Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4a9ae827-6dc8-4573-8ac7-8239d42aa03f')
  'Template Spec Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '1c9b6475-caf0-4164-b5a1-2142a7116f4b')
  'Template Spec Reader': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '392ae280-861d-42bd-9ea5-08ee6d83b80e')
  'User Access Administrator': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9')
}

resource account 'Microsoft.CognitiveServices/accounts@2022-12-01' existing = {name: last(split(resourceId, '/'))}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for principalId in principalIds: {
  name: guid(resourceId, principalId, roleDefinitionIdOrName)
  properties: {
    description: description
    roleDefinitionId: contains(builtInRoleNames, roleDefinitionIdOrName) ? builtInRoleNames[roleDefinitionIdOrName] : roleDefinitionIdOrName 
    principalId: principalId
    principalType: !empty(principalType) ? any(principalType) : null
    condition: !empty(condition) ? condition : null
    conditionVersion: !empty(conditionVersion) && !empty (condition) ? conditionVersion : null // Must only be set if condtion is set
    delegatedManagedIdentityResourceId: !empty(delegatedManagedIdentityResourceId) ? delegatedManagedIdentityResourceId : null
  }
  scope: account
}]
