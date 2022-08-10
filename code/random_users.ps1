param([Parameter(Mandatory=$true)] $OutputJSONFile)

# gather variables from the data directory
$groupNames = [System.Collections.ArrayList](Get-Content "data/group_names.txt")
$firstNames = [System.Collections.ArrayList](Get-Content "data/first_names.txt")
$lastNames = [System.Collections.ArrayList](Get-Content "data/last_names.txt")
$passwords = [System.Collections.ArrayList](Get-Content "data/passwords.txt")

# define variables
$groups = @()
$users = @()

# generate 10 groups
$numGroups = 10
for ($i =0; $i -lt $numGroups; $i++){
    $groupName = (Get-Random -InputObject $groupNames)
    $group = @{"name"="$groupName"}
    $groups += $group

    # maintain unique groups
    $groupNames.Remove($newGroup)
}

# generate random users
$numUsers = 100
for ($i =0; $i -lt $numUsers; $i++){
    $firstName = (Get-Random -InputObject $firstNames)
    $lastName = (Get-Random -InputObject $lastNames)
    $password = (Get-Random -InputObject $passwords)

    # generate new user
    $newUser = @{
        "name"="$firstName $lastName"
        "password"="$password"
        "groups" = @((Get-Random -InputObject $groups).name)
        }
    $users += $newUser

    #maintain unique variables
    $firstNames.Remove($firstName)
    $lastNames.Remove($lastName)
    $passwords.Remove($password)
}

echo @{
    "domain"="adtest.local"
    "groups"=$groups
    "users"=$users
} | ConvertTo-Json | Out-File $OutputJSONFile
