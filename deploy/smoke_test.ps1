# Connect to the VM
$vm = Connect-VM -Name myVM -ComputerName myHost

# Verify that the VM is online
if (!$vm.State -eq "Running") {
    Write-Error "VM is not online"
    exit 1
}

# Verify that the VM is properly provisioned
Write-Output "RAM: $($vm.MemoryAssignedMB)"
Write-Output "CPU: $($vm.NumberOfCores)"
Write-Output "Storage: $($vm.StorageTotalMB)"

# Verify that the VM is able to boot up and run the desired operating system
$operatingSystem = $vm.OperatingSystem
if ($operatingSystem.Name -ne "Windows Server 2012 R2") {
    Write-Error "Incorrect operating system: $($operatingSystem.Name)"
    exit 1
}

# Verify that the VM is able to connect to the network
$networkAdapters = $vm.NetworkInterfaces
if ($networkAdapters.Count -ne 1) {
    Write-Error "Incorrect number of network adapters: $($networkAdapters.Count)"
    exit 1
}

# Verify that the VM is able to access shared resources
$sharedFolders = $vm.Storage.Shares
if ($sharedFolders.Count -ne 1) {
    Write-Error "Incorrect number of shared folders: $($sharedFolders.Count)"
    exit 1
}

# The VM passed the smoke test!
Write-Output "Smoke test passed"
exit 0
