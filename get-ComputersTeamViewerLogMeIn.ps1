
get-ADcomputer -Filter * | ? {$_.DistinguishedName -like "*ou=Computers,*"} |foreach{`
    $com=$_
    Get-RemoteProgram -ComputerName $com.Name | Where-Object {$_.programname -like '*LogMeIn*' -or $_.Programname -like '*TeamViewer*'}}
