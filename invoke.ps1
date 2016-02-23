#(Get-Credential).password | Converfrom-secureString | out-file "C:\PSscripts\password.txt"


$pass = Get-Content "\\freenas\freenas\password.txt" | ConvertTo-SecureString
$User = "camarketing\administrator"
$File = "\\freenas\freenas\password.txt"
$MyCredential=New-Object -TypeName System.Management.Automation.PSCredential `
 -ArgumentList $User, (Get-Content $File | ConvertTo-SecureString)
 Invoke-Command -ComputerName itjuan -ScriptBlock {get-Service} -Credential $MyCredential
