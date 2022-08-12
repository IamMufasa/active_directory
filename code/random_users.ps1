param([Parameter(Mandatory=$true)] $OutputJSONFile, [int]$userCount, [int]$groupCount, [int]$localAdminCount)

# define variables
$groups = @()
$users = @()

# gather variables from the data directory
$groupNames = [System.Collections.ArrayList](Get-Content "data/group_names.txt")
$firstNames = [System.Collections.ArrayList](Get-Content "data/first_names.txt")
$lastNames = [System.Collections.ArrayList](Get-Content "data/last_names.txt")
$passwords = [System.Collections.ArrayList](Get-Content "data/passwords.txt")

# check and set parameters if not set
if ($userCount -eq 0){
    $userCount = read-host -Prompt "Enter the number of users (5 if blank)"}
if ($groupCount -eq 0){
    $groupCount = read-host -Prompt "Enter the number of groups (1 if blank)"}
if ($localAdminCount -eq 0){
    $localAdminCount = read-host -Prompt "Enter the number of local admins (1 if blank)"}

# Default UserCount set to 5 (if not set)
if ( $UserCount -eq 0 ){
    $UserCount = 5}

# Default GroupCount set to 1 (if not set)
if ( $GroupCount -eq 0 ){
    $GroupCount = 1}

# Default localAdminCount set to 1 (if not set)
if ($localAdminCount -eq 0){
    $localAdminCount = 1}

# Set number of local admin accounts
if ($localAdminCount -ne 0){
    $localAdminIndexes = @()
    # select admin accounts from random users
    while (($localAdminIndexes | Measure-Object).Count -lt $localAdminCount){
        # while adminIndex is lower than adminCount, add randomIndex where randomIndex is not contained in adminIndex
        $randomIndex = (Get-Random -InputObject(1..($userCount)) | Where-Object {$localAdminIndexes -notcontains $_})
        $localAdminIndexes += @($randomIndex)
    }
}

# generate random groups
for ($i=1; $i -le $groupCount; $i++){
    $groupName = (Get-Random -InputObject $groupNames)
    $group = @{"name"="$groupName"}
    $groups += $group

    # maintain unique groups
    $groupNames.Remove($newGroup)
}

# generate random users
for ($i=1; $i -le $userCount; $i++){
    $firstName = (Get-Random -InputObject $firstNames)
    $lastName = (Get-Random -InputObject $lastNames)
    $password = (Get-Random -InputObject $passwords)

    # generate new user
    $newUser = @{
        "name"="$firstName $lastName"
        "password"="$password"
        "groups" = @((Get-Random -InputObject $groups).name)
        }
    # check for local admin
    if($localAdminIndexes | Where {$_ -eq $i}){
        echo "User $i is a local admin"
        $newUser."localAdmin" = $true
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
