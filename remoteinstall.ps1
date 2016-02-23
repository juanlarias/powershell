
$server='itjuan'
$OU="OU=Computers,OU=customer service,DC=CAMARKETING,DC=LOCAL"
$sc="CUSTSERVJAZLING"
$computers= get-ADcomputer -Filter * -SearchBase $OU | select name
foreach($computer in $sc){
    Get-Service remoteregistry -ComputerName $computer | start-service

    ROBOCOPY "\\$server\nettools\software\dazzle" "\\$computer\c$\windows\temp\"

    $InstallString = 'c:\windows\temp\dazzle\setup.exe /silent'

    if (([WMICLASS]"\\$computer\ROOT\CIMV2:Win32_Process").Create($InstallString)){
        Write-Host "install completed on $computer"
        }
     else{
        Write-Host "install fail on $computer"
        [string[]]$cfaills+=$computer
    }
}




#PS C:\WINDOWS\system32> ([wmiclass]"\\localhost\ROOT\CIMV2:Win32_Process").create("E:\install\dazzle\setup.EXE /silent")

#Get-Service remoteregistry -ComputerName $computer | start-service
#Copy-item "\\$server\share\Office 2010" -conatiner -recurse \\$computer\c$\windows\temp\
#$InstallString = '"C:\windows\temp\Office 2010\setup.exe" /adminfile Updates/OfficeSetup.MSP /config ProPlus.WW/config.xml"'
#([WMICLASS]"\\$computer\ROOT\CIMV2:Win32_Process").Create($InstallString)