# Install Azure PowerShell module
Install-Module -Name Az -Force

# Set VM name
$vm_name="VM-AD"

# Connect to the VM
$vm = Connect-AzVM -Name $vm_name -ResourceGroupName myResourceGroupName

# Verify that the VM is online
if (!$vm.PowerState -eq "Running") {
  Write-Error "VM is not online"
  exit 1
}

# Verify that the VM is properly provisioned
Write-Output "RAM: $($vm.HardwareProfile.MemoryInMB)"
Write-Output "CPU: $($vm.HardwareProfile.NumberOfCores)"
Write-Output "Storage: $($vm.StorageProfile.OsDisk.DiskSizeGB)"

# Verify that the VM is able to boot up and run the desired operating system
$operatingSystem = $vm.StorageProfile.OsDisk.OsType
if ($operatingSystem -ne "WindowsServer2012R2") {
  Write-Error "Incorrect operating system: $($operatingSystem)"
  exit 1
}

# Verify that the VM is able to connect to the network
$networkAdapters = $vm.NetworkProfile.NetworkInterfaces
if ($networkAdapters.Count -ne 1) {
  Write-Error "Incorrect number of network adapters: $($networkAdapters.Count)"
  exit 1
}

# Verify that the VM is able to access shared resources
$sharedFolders = $vm.StorageProfile.OsDisk.SharedAccessSignature
if ($sharedFolders.Count -ne 1) {
  Write-Error "Incorrect number of shared folders: $($sharedFolders.Count)"
  exit 1
}

# The VM passed the smoke test!
Write-Output "Smoke test passed"
exit 0
