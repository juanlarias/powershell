$SERVER='itjuan'
$SERVERINSTALLPATH='notepad'
$OU="OU=Computers,OU=customer service,DC=CAMARKETING,DC=LOCAL"
$COMPUTERS="NJ-SVR-JF-ED"
$CONFIGFILEPATH="$SERVER\$SERVERINSTALLPATH\VisPro.ww\config.xml"

[string[]]$COMPUTERSFAILTOINSTALL=''

#$computers= get-ADcomputer -Filter * -SearchBase $OU | select name

foreach($COMPUTER IN $COMPUTERS){
        Get-Service remoteregistry -ComputerName $COMPUTER | start-service

        #ROBOCOPY "\\$SERVER\$SERVERINSTALLPATH" "\\$COMPUTER\c$\temp\$SERVERINSTALLPATH" /MIR

        $INSTALLSTRING = "C:\TEMP\notepad\npp.exe"
        

         $NEWPROC=([WMICLASS]"\\$COMPUTER\ROOT\CIMV2:Win32_Process").Create("$INSTALLSTRING") 
         IF($NEWPROC.ReturnValue -EQ 0){
            Write-Host "Installation proccess create $NEWPROC.ProcessId" -foregroundcolor "green"
            #Out-File -FilePath c:\test\file.txt 
            }
         else{
            Write-Host "Installation Process fail with $NEWPROC.ReturnValue" -foregroundcolor "Red"
            $COMPUTERSFAILTOINSTALL+=$COMPUTER
             #Out-File -FilePath c:\test\file.txt 
            }

}get-content C:\test\file.txt