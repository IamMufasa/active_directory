param([Parameter(Mandatory=$true)] $OutputJSONFile, [int]$userCount, [int]$groupCount)

# gather variables from the data directory
$groupNames = [System.Collections.ArrayList](Get-Content "data/group_names.txt")
$firstNames = [System.Collections.ArrayList](Get-Content "data/first_names.txt")
$lastNames = [System.Collections.ArrayList](Get-Content "data/last_names.txt")
$passwords = [System.Collections.ArrayList](Get-Content "data/passwords.txt")

# define variables
$groups = @()
$users = @()

# Default UserCount set to 5 (if not set)
if ( $UserCount -eq 0 ){
    $UserCount = 5
}

# Default GroupCount set to 5 (if not set)
if ( $GroupCount -eq 0 ){
    $GroupCount = 1
}

# generate random groups
for ($i =0; $i -lt $groupCount; $i++){
    $groupName = (Get-Random -InputObject $groupNames)
    $group = @{"name"="$groupName"}
    $groups += $group

    # maintain unique groups
    $groupNames.Remove($newGroup)
}

# generate random users
for ($i =0; $i -lt $userCount; $i++){
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

ConvertTo-Json -InputObject @{
    "domain"="adtest.local"
    "groups"=$groups
    "users"=$users
} | Out-File $OutputJSONFile
