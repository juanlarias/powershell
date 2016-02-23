#$url="https://camarketinginc.zendesk.com/api/v2/users/show_many.json?ids=1,2,3"

#Remove-Item data.csv
$data=''
$final=@{}

$url='https://camarketinginc.zendesk.com/api/v2/users/search.json?role=end-user'
$username='juan@camarketing.com'
$password='juanluis'
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
$payload=5
for ($i = 1; $i -lt $payload; $i++)
{ 
    
    Write-Host '*****************************************************************'
    Write-Host "               Getting Payload $i of $payload"
    Write-Host '*****************************************************************'
    $ditem=0
    $data=Invoke-RestMethod -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Uri $url -Verbose
    foreach ($item in $data.users)
    {
       $final= New-Object -TypeName PSObject -Property  @{id=$item.id
                                                          mail=$item.email
                                                          name=$item.name
                                                          role=$item.role
                                                          suspended=$item.suspended}
      #    $final | export-csv data.csv -Append
          if ($item.role -eq 'end-user' -and $item.suspended -eq $false)
          {
                #Write-Host $final
                $ditem++
                $did=$item.id
                Invoke-RestMethod -Uri "https://camarketinginc.zendesk.com/api/v2/users/destroy_many.json?ids=$did"`
                                  -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}`
                                  -Method Delete | Out-Null   
          }
          
    }

    write-host "**************Payload $i : $ditem Records Deleted********" -ForegroundColor Red
}
<#
Invoke-Item data.csv




foreach ($did in (get-content data.txt))
{
    Invoke-RestMethod -Uri "https://camarketinginc.zendesk.com/api/v2/users/destroy_many.json?ids=$did"`
                      -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}`
                      -Method Delete -Verbose
}
#>