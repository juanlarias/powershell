
$d1=(get-date).AddDays(-30)
Get-ADComputer -filter {lastlogondate -lt $d1} | Move-ADObject -TargetPath "OU=Disable Computers,DC=domain,DC=LOCAL"
