# CrackMapExec

CrackMapExec is a post-exploitation tool that I will us in a Kali Linux Virtual Machine to test active directory enumeration and brute force cracking techniques. The CrackMapExec GitBook can be found [here](https://wiki.porchetta.industries/).

## Techniques tested
 * [System Information Discovery](https://attack.mitre.org/techniques/T1082/)
 ```shell
 crackmapexec smb 192.168.179.0/24
 ```
 The target IP addresses or domain names found when performing a system information discovery can be added to a text document and used in later crackmapexec commands. IP addresses can be stored in multiples such as `196.168.1.0 192.168.0.2` or `192.168.1.0-28 10.0.0.1-67` or by subnet `192.168.1.0/24`.

* [Brute Force: Password Spraying](https://attack.mitre.org/techniques/T1110/003/)
```shell
 crackmapexec smb targets.txt -u users.txt -p passwords.txt
 ```
It is possible to add ` | grep +` or ` > passwordspray.txt` at the end of the command to grab only valid credentials or store the results in a text document for later viewing.

* [Account Discovery (local and domain)](https://attack.mitre.org/techniques/T1087/)
```shell
smb targets.txt -u csharp -p 111111 --users
```

* [Password Policy Discovery](https://attack.mitre.org/techniques/T1201/)
```shell
smb targets.txt -u csharp -p 111111 --pass-pol
```
