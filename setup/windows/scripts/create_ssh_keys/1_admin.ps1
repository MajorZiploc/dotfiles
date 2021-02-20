# Check open ssh services - should give back client and service
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# NOTE: Unsure if the following is required
# Start-Service sshd
# # OPTIONAL but recommended:
# Set-Service -Name sshd -StartupType 'Automatic'
# # Confirm the Firewall rule is configured. It should be created automatically by setup.
# Get-NetFirewallRule -Name *ssh*
# # There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
# # If the firewall does not exist, create one
# New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

# Configure SSH service to automatically start
Get-Service ssh-agent | Set-Service -StartupType Automatic -PassThru | Start-Service
start-ssh-agent.cmd

