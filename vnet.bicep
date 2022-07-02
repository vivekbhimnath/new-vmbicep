//third
param vnetname string
param subnetname string
param location string = resourceGroup().location
param nsgname string
//param addressprefix string

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-08-01' existing ={
  name:nsgname
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01'={
  name:vnetname
  location:location
  properties:{
    addressSpace:{
      addressPrefixes: [
        '10.0.0.0/16'
      ]    
    }
  }
}


resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-08-01'={
  name:subnetname
  parent:vnet
  properties:{
    addressPrefix: '10.0.0.0/24'
    networkSecurityGroup:{
      id: nsg.id
    }
  }
}

output subnetid string = subnet.id
output vnetid string = vnet.id
