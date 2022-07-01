//first
targetScope = 'subscription'
param rg_name string
param location string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01'={
  name: rg_name
  location: location 
}
