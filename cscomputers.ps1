$OU="OU=Computers,OU=customer service,DC=CAMARKETING,DC=LOCAL"
$cscomputers= get-ADcomputer -Filter * -SearchBase $OU | select name
$cscomputers
