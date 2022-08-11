# Active Directory Setup for Security Testing

This repository is purposed for security testing in a modern Windows Active Directory domain which is hosted using Windows Server 2022 and consists of Windows 11 workstations. This repository is meant to hold walkthroughs and scripts which can be used to quickly generate active directory domains at scale in a virtual environment. 

## Various adversarial enumeration and discovery techniques which can be tested with this environment:
* [Account Discovery (local and domain)](https://attack.mitre.org/techniques/T1087/)
* [System Owner/User Discovery](https://attack.mitre.org/techniques/T1033/)
* [Domain Trust Discovery](https://attack.mitre.org/techniques/T1482/)
* [Password Policy Discovery](https://attack.mitre.org/techniques/T1201/)
* [Group Policy Discovery](https://attack.mitre.org/techniques/T1615/)
* [Permission Groups Discovery](https://attack.mitre.org/techniques/T1069/)
* [System Information Discovery](https://attack.mitre.org/techniques/T1082/)
* [File and Directory Discovery](https://attack.mitre.org/techniques/T1083/)
* [Network Share Discovery](https://attack.mitre.org/techniques/T1135/)
* [System Network Configuration Discovery](https://attack.mitre.org/techniques/T1016/)
* [System Network Connections Discovery](https://attack.mitre.org/techniques/T1049/)


## Various adversarial defense evasion and credential access techniques which can be tested with this environment:
* [Modify Registry](https://attack.mitre.org/techniques/T1112/)
* [Domain Policy Modification](https://attack.mitre.org/techniques/T1484/)
* [File and Directory Permissions Modification](https://attack.mitre.org/techniques/T1222/)
* [Access Token Manipulation](https://attack.mitre.org/techniques/T1134/)
* [Use Alternate Authentication Material](https://attack.mitre.org/techniques/T1550/)
* [Indicator Removal on Host](https://attack.mitre.org/techniques/T1070/)
* [OS Credential Dumping](https://attack.mitre.org/techniques/T1003/)
* [Steal or Forge Kerberos Tickets](https://attack.mitre.org/techniques/T1558/)
* [Brute Force](https://attack.mitre.org/techniques/T1110/)
* [Brute Force: Password Spraying](https://attack.mitre.org/techniques/T1110/003/)


*This environment can also be used to test other adversarial tactics such as persistence, privilege escalation, lateral movement, collection, command and control, exfiltration, and impact.*
