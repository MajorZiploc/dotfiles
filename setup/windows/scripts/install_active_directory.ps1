
Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online


# should give access to this module:
# Import-Module ActiveDirectory
#
# Check modules installed with:
# Get-Module -ListAvailable
