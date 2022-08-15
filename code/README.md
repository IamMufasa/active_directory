# This code found in this repository is designed to automate the creation of domain users for Windows Active Directory

The `gen_ad.ps1` script can be used in combination with a JSON file to generate domain users, domain local groups, and local administrator accounts on the domain controller. The `-Undo` parameter may be added to this script to reverse any changes made.

The `ad_schema.json` file offers the schema of how the JSON files are structured. 

The `random_users.ps1` script can be used with data pulled from the active_directory\data directory to randomize the creation of domain users. See the command parameters below.
```shell
.\random_users.ps1 (OutputFile.json) (users) (groups) (localAdmins)
```
