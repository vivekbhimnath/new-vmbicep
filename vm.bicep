//fifth
param vmname string
param location string = resourceGroup().location
param username string
@secure()
param password string
param computerName string
param nicname string

resource nic 'Microsoft.Network/networkInterfaces@2021-08-01' existing ={
  name: nicname
}


resource vm 'Microsoft.Compute/virtualMachines@2022-03-01'={
   name:vmname
   location:location
   identity:{
    type:'SystemAssigned'

     }
    properties:{
      osProfile:{
        adminUsername: username
        adminPassword: password
        computerName: computerName
      }
      hardwareProfile:{
        vmSize: 'Standard_B1ls'  
      }
      storageProfile:{
        imageReference: {
          publisher:'MicrosoftWindowsServer'
          sku:'2019-datacenter-gensecond'
          offer:'WindowsServer'
          version:'latest'
        }
        // osDisk:{
        //   createOption:'Attach'
        // }
      }
      networkProfile:{
        networkApiVersion:'2020-11-01'
        networkInterfaces:[
          {
            id: nic.id
            properties:{
              deleteOption:'Delete'
              primary:false
            }
          }
        ]
      }
      securityProfile:{
  
      }
    }
    dependsOn: [
      nic
    ]    
 }
