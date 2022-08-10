# Generate Active Directory Domain Users using script

1. Find PowerShell script and JSON object in active_directory/code

2. You can randomly generate JSON objects using `random_users.ps1` or utilize the existing JSON file `ad_schema.json` or `random.json`.

2. Run the script on the Domain Controller and specify your JSON file
```shell
./gen_ad.ps1 ad_schema.json
```