//second
param nsgname string
param location string = resourceGroup().location


resource nsg 'Microsoft.Network/networkSecurityGroups@2021-08-01'={
  name:nsgname
  location: location
  properties:{
    securityRules:[]
  
  }
}
