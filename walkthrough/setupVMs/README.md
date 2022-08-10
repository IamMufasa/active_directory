# Setting up the Domain Controller

1. Use `sconfig` or a managemnet client to configure the domain controller:
    - Change the hostname
    - Change the IP address to static
    - Change the DNS server to our own IP address

2. Install the Active Directory Windows Feature

```shell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

3. Configure Windows Active Directory Server 2022

```shell
import-Module ADDSDeployment
```
```shell
install-ADDSForest
```

# Setting up Management Client

1. Set up remote management to the Domain Controller
    ```shell
    Start-Service WinRM
    ```
    ```shell
    set-item wsman:\localhost\Client\TrustedHosts -value 192.168.179.199
    ```

2. Set up a variable for a Power Shell session to the Domain Controller
    ```shell
    $dc = New-PSSession -ComputerName 192.168.179.199 -Credential (Get-Credential)
    ```

3. Enter the Domain Controller through the remote session
    ```shell
    Enter-PSSession $dc
    ```


# Setting up Domain Workstation

1. Change the DNS server on the Workstation
    ```shell
    Get-DNSClientServerAddress
    ```
    ```shell
    Set-DNSClientServerAddress -InterfaceIndex 5 -ServerAddresses 192.168.179.199
    ```

2. Add the Workstation to the domain
    ```shell
    Add-Computer -DomainName adtest.local -Credential adtest\Administrator -Force -Restart
    ```
    