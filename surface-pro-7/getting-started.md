# Getting started

## Requirements

- [ ] Windows 11 Update 22H2
- [ ] Docker Desktop

## Enable SSH Agent

[(Source)](https://learn.microsoft.com/de-de/windows-server/administration/openssh/openssh_keymanagement)

1. Open a powershell terminal
1. Create a SSH keypair (if you don't have a keypair, yet)
   1. `rsa` keypairs are more compatible
      1. `ssh-keygen -t rsa -b 4096 -f keypair_name.rsa`
   1. The newer and safer type is `ed25519`, but on older systems, it may not work properly
      1. `ssh-keygen -t ed25519 -f keypair_name.ed25519`
1. Start the `ssh-agent`

    ```sh
    # By default the ssh-agent service is disabled. Allow it to be manually started for the next step to work.
    # Make sure you're running as an Administrator.
    Get-Service ssh-agent | Set-Service -StartupType Manual
    # Start the service
    Start-Service ssh-agent
    # This should return a status of Running
    Get-Service ssh-agent
    # Now load your key files into ssh-agent
    ssh-add ~\.ssh\keypair_name
    ```
