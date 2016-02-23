$userdatatemp= Get-ChildItem ENV:temp
$temp=Get-ChildItem ENV:windir

$pctemp=$temp.Value+'\temp\*'
$usertemp=$userdatatemp.Value+'\*'

Remove-Item -Path $pctemp -Force -Recurse
Remove-Item -Path $usertemp -Force -Recurse
