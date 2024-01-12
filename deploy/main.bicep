@description('Username for the Virtual Machine.')
param adminUsername string
@description('Password for the Virtual Machine.')
@minLength(12)
@secure()
param adminPassword string
@description('The Windows version for the VM. This will pick a fully patched image of this given Windows version.')
param OSVersion string = '2022-datacenter-azure-edition'

@description('Size of the virtual machine.')
param vmSize string = 'Standard_D2s_v5'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of the virtual machine.')
param vmName string = 'simple-vm'

@description('Security Type of the Virtual Machine.')
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'TrustedLaunch'
module net 'modules/Network.bicep' =  {
  name: 'network'
  params: {
    location: location
  }
}
module VM 'modules/VM.bicep' = {
  name: vmName
  params: {
    adminPassword: adminPassword
    adminUsername: adminUsername
    vmName: vmName
    vmSize: vmSize
    OSVersion:OSVersion
    securityType:securityType
    location:location
  }
}
