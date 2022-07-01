//fourth
param nicname string
param location string = resourceGroup().location
param subnetname string
param ipconfigNamE string
param vnetname string

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01' existing = {
  name:subnetname
}
resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' existing = {
  name:vnetname
}
resource nic 'Microsoft.Network/networkInterfaces@2021-08-01'={
  name:nicname
  location:location
  properties:{
    enableAcceleratedNetworking:true
    ipConfigurations:[
      {
        name: ipconfigNamE
        properties:{
          privateIPAllocationMethod:'Dynamic'
          subnet:{
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnet.name)
          }
        }
      }      
    ] 
  }
}

output nicid string= nic.id

