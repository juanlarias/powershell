﻿#(Get-Credential).password | Converfrom-secureString | out-file "C:\PSscripts\password.txt"


$pass = Get-Content "\\freenas\freenas\password.txt" | ConvertTo-SecureString
$User = "domain\administrator"
$File = "\\freenas\freenas\password.txt"
$MyCredential=New-Object -TypeName System.Management.Automation.PSCredential `
 -ArgumentList $User, (Get-Content $File | ConvertTo-SecureString)
 Invoke-Command -ComputerName name -ScriptBlock {get-Service} -Credential $MyCredential
