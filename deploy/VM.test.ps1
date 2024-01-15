ping $vm_name
# Verify that the VM is online

if (!$vm.State -eq "Running") {
    Write-Error "VM $vm_name is not online"
    exit 1
  }