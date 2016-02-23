cls
$file=''
$url='https://camarketinginc.zendesk.com/api/v2/users/search.json?query=role:end-user'
$username='juan@camarketing.com'
$password='juanluis'
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
$file=Invoke-RestMethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $url -Verbose 
foreach ($item in $file.users)
{
   $final= New-Object -TypeName PSObject -Property  @{id=$item.id
                                                      mail=$item.email
                                                      name=$item.name
                                                      role=$item.role
                                                      suspended=$item.suspended}
  
           Write-Host $final
}

