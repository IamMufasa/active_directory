param([Parameter(Mandatory=$true)] $JSONFile)

function CreateADGroup(){
    param([Parameter(Mandatory=$true)] $groupObject)

    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
}

function CreateADUser(){
    param([Parameter(Mandatory=$true)] $userObject)
    
    # Pull out variables from the JSON object
    $name = $userObject.name
    $password =$userObject.password

    # Generate a "first initial + last name" structure for username
    $firstName, $lastName = $name.Split(" ")
    $username = ($firstName[0] + $lastName).ToLower()
    $samAccountName = $username
    $principalName = $username

    # Create AD User object using pulled variables
    New-ADUser -Name "$name" -GivenName $firstName -Surname $lastName -SamAccountName $samAccountName -UserPrincipalName $principalName@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount
    
    # Add the user to its associated groups
    foreach($groupName in $userObject.groups) {
        try {
            Get-ADGroup -Identity "$groupName"
            Add-ADGroupMember -Identity $groupName -Members $username
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
            Write-Warning "User $name not added to the group $groupName because this group does not exist."
        }
    }
}

$json = (Get-Content $JSONFile | ConvertFrom-JSON)

$Global:Domain = $json.domain

foreach ( $group in $json.groups){
    createADGroup $group
}

foreach($user in $json.users){
    CreateADUser $user
}