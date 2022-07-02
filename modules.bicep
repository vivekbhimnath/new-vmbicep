param rg_name string
param location string = 'east us'
param subscriptionId string
param nsgname string
param vnetname string
param subnetname string
param nicname string
param ipconfigNamE string

param vmname string
param username string
param password string
param computerName string


targetScope = 'subscription'

module rg './resource_grp.bicep' ={
  scope: subscription(subscriptionId)
  name:'rg_deploy'
  params:{
    rg_name: rg_name
    location: location

  }
}

module nsg 'nsg.bicep'={
  scope: resourceGroup(rg_name)
  name: 'nsg_deploy'
#disable-next-line explicit-values-for-loc-params
  params:{
    nsgname: nsgname
    location:location
  }
  dependsOn:[
    rg
  ]
}

module vnetsubnet 'vnet.bicep'={
  scope: resourceGroup(rg_name)
  name:'vnet_subnet_deploy'
//disable-next-line explicit-values-for-loc-params
  params:{
    nsgname: nsgname
    vnetname: vnetname
    subnetname:  subnetname
    location:location
  }
  dependsOn:[
    rg
  ]
}

module nic 'nic.bicep'={
  scope: resourceGroup(rg_name)
  name: 'nic_deploy'
//disable-next-line explicit-values-for-loc-params
  params:{
    nicname: nicname
    subnetname: subnetname
    ipconfigNamE: ipconfigNamE
    vnetname: vnetname
    location:location
  }
  dependsOn:[
    rg
  ]
}

module vm 'vm.bicep'={
  scope: resourceGroup(rg_name)
  name: 'vm_deploy'
//disable-next-line explicit-values-for-loc-params
  params:{
    vmname: vmname
    computerName: computerName
    nicname: nicname
    username: username
    password: password
    location:location
  }
  dependsOn:[
     rg
  ]
}

