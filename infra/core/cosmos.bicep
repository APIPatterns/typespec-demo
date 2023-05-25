@description('Default value obtained from resource group, it can be overwriten')
param location string = resourceGroup().location

@description('Cosmos DB account name, max length 44 characters, lowercase')
@minLength(1)
@maxLength(44)
param accountName string = 'sql-${uniqueString(resourceGroup().id)}'

@description('The default consistency level of the Cosmos DB account.')
@allowed([
  'Eventual'
  'ConsistentPrefix'
  'Session'
  'BoundedStaleness'
  'Strong'
])
param defaultConsistencyLevel string = 'Session'

@description('Enable automatic failover for regions')
param automaticFailover bool = true

@description('The name for the database')
@minLength(1)
param databaseName string

@description('The name for the container')
@minLength(1)
param containerName string

@description('Name for diagnostic settings')
@minLength(1)
param diagnosticSettingsName string = 'cosmosDbDiagnostics'

@description('Log analytics workspace id')
@minLength(1)
param logAnalyticsWorkspaceId string

var accountNameVar = toLower(accountName)
var locations = [
  {
    locationName: location
    failoverPriority: 0
    isZoneRedundant: false
  }
]

resource accountNameResource 'Microsoft.DocumentDB/databaseAccounts@2021-01-15' = {
  name: accountNameVar
  kind: 'GlobalDocumentDB'
  location: location
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: defaultConsistencyLevel
    }
    locations: locations
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: automaticFailover
  }

  resource database 'sqlDatabases' = {
    name: databaseName
    properties: {
      resource: {
        id: databaseName
      }
    }

    resource container 'containers' = {
      name: containerName
      properties: {
        resource: {
          id: containerName
          partitionKey: {
            paths: [
              '/id'
            ]
            kind: 'Hash'
          }
        }
      }
    }
  }
}

resource cosmosDbDiagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: diagnosticSettingsName
  scope: accountNameResource
  properties: {
    logs: [
      {
        category: 'DataPlaneRequests'
        enabled: true
      }
      {
        category: 'QueryRuntimeStatistics'
        enabled: true
      }
      {
        category: 'PartitionKeyStatistics'
        enabled: true
      }
      {
        category: 'PartitionKeyRUConsumption'
        enabled: true
      }
      {
        category: 'ControlPlaneRequests'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'Requests'
        enabled: true
      }
    ]
    workspaceId: logAnalyticsWorkspaceId
  }
}

output cosmosDBId string = accountNameResource.id
output cosmosDBEndpoint string = accountNameResource.properties.documentEndpoint
output cosmosDBAccountName string = accountNameResource.name
