.OUTPUTS
    None 
.NOTES


param
(
    [Parameter(Mandatory=$true)] [System.Object]$env,
    [Parameter(Mandatory=$true)] [System.Object]$project  
)

$group = "azure-${project}-${env}-owner"

$groupId = Get-zureADGroup -Filter "displayName eq '$group'" 

output $groupId.ObjectId

