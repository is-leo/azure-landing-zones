/*
  SYNOPSIS: Module for provisioning CDN profile endpoint.
  DESCRIPTION: This module provisions an Azure CDN Profile Endpoint. It creates and configures a CDN endpoint as part of the specified CDN profile.
  VERSION: 1.0.0
  OWNER TEAM: Cegal CloudOps 
*/

@description('The host name (address) of the origin server.')
param originHostName string

@description('Indicates whether the CDN endpoint requires HTTPS connections.')
param httpsOnly bool

@description('A unique suffix to add to resource names that need to be globally unique.')
@maxLength(13)
param resourceNameSuffix string = uniqueString(resourceGroup().id)

@description('The name of the CDN profile.')
var profileName string = 'cdn-${resourceNameSuffix}'

@description('The name of the CDN endpoint')
var endpointName string = 'endpoint-${resourceNameSuffix}'

@description('The name of the origin server for the CDN endpoint.')
var originName string = 'my-origin'


resource cdnProfile 'Microsoft.Cdn/profiles@2024-09-01' = {
  name: profileName
  location: 'global'
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource endpoint 'Microsoft.Cdn/profiles/endpoints@2024-09-01' = {
  parent: cdnProfile
  name: endpointName
  location: 'global'
  properties: {
    originHostHeader: originHostName
    isHttpAllowed: !httpsOnly
    isHttpsAllowed: true
    queryStringCachingBehavior: 'IgnoreQueryString'
    contentTypesToCompress: [
      'text/plain'
      'text/html'
      'text/css'
      'application/x-javascript'
      'text/javascript'
    ]
    isCompressionEnabled: true
    origins: [
      {
        name: originName
        properties: {
          hostName: originHostName
        }
      }
    ]
  }
}

@description('The host name of the CDN endpoint.')
output endpointHostName string = endpoint.properties.hostName
