$OU="OU=Computers,OU=customer service,DC=Domain,DC=LOCAL"
$cscomputers= get-ADcomputer -Filter * -SearchBase $OU | select name
$cscomputers
