param(
  [Parameter(Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string] $HostName
)

    # Example: Check if the VM responds to ping (replace with your specific check)
    if (ping $HostName) {
        Write-Host "Operating System Check: Passed"
    } else {
        Write-Host "Operating System Check: Failed"
    }

    # Additional OS checks can be added here

ping $HostName
# Function to perform other tests...

# Additional tests can be added by calling corresponding functions

# End of script
