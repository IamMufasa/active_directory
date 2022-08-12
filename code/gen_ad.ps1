param([Parameter(Mandatory=$true)] $JSONFile, [switch]$undo)

function createADGroup(){
    param([Parameter(Mandatory=$true)] $groupObject)

    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
}

function removeADGroup(){
    param([Parameter(Mandatory=$true)] $groupObject)

    $name = $groupObject.name
    Remove-ADGroup -Identity $name -Confirm:$False
}

function createADUser(){
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

    # Add to local admin group
    if($userObject.localAdmin -eq $True){
    net localgroup administrators $Global:Domain\$username /add
    }
}

function removeADUser(){
    param([Parameter(Mandatory=$true)] $userObject)
    $name = $userObject.name
    $firstName, $lastName = $name.Split(" ")
    $username = ($firstName[0] + $lastName).ToLower()
    $samAccountName = $username

    Remove-ADUser -Identity $samAccountName -Confirm:$False
}

# Changes the Password Complexity and length for later pentesting
function weakenPasswordPolicy() {
    secedit /export /cfg c:\Windows\Tasks\secpol.cfg
    (Get-Content C:\Windows\Tasks\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0").replace("MinimumPasswordLength = 7", "MinimumPasswordLength = 1") | Out-File C:\Windows\Tasks\secpol.cfg
    secedit /configure /db c:\windows\security\local.sdb /cfg c:\Windows\Tasks\secpol.cfg /areas SECURITYPOLICY
    rm -force c:\Windows\Tasks\secpol.cfg -confirm:$false
}

# Changes the Password Complexity back
function stregthenPasswordPolicy() {
    secedit /export /cfg c:\Windows\Tasks\secpol.cfg
    (Get-Content C:\Windows\Tasks\secpol.cfg).replace("PasswordComplexity = 0", "PasswordComplexity = 1").replace("MinimumPasswordLength = 1", "MinimumPasswordLength = 7") | Out-File C:\Windows\Tasks\secpol.cfg
    secedit /configure /db c:\windows\security\local.sdb /cfg c:\Windows\Tasks\secpol.cfg /areas SECURITYPOLICY
    rm -force c:\Windows\Tasks\secpol.cfg -confirm:$false
}

# define variables
$json = (Get-Content $JSONFile | ConvertFrom-JSON)
$Global:Domain = $json.domain

# weaken password policy and create users and groups
if(-not $undo) {
    weakenPasswordPolicy
    foreach ( $group in $json.groups){
        createADGroup $group}
    foreach($user in $json.users){
        createADUser $user}
}else{
    stregthenPasswordPolicy
    foreach($user in $json.users){
        removeADUser $user}
    foreach ( $group in $json.groups){
        removeADGroup $group}
}