 $servers=Get-Content .\SERVERLIST.TXT
 $null | Out-File FailSVRs.txt
 $null | Out-File ShutdownSVRs.txt
 
Write-Host "____________________________________________________________________________" -ForegroundColor Red
Write-host "WARNING THIS WILL SHUTDOWN ALL SERVERS LISTED ON THE SERVERLIST.TXT DOCUMENT" -ForegroundColor Red 
Write-Host "____________________________________________________________________________" -ForegroundColor Red
if ((read-host "DO YOU WANT TO CONTINUE Y(YES) N(NO/EXIT)") -eq 'Y'){
     foreach ($servname in $servers)
     {
        if (Test-Connection -computername $servname -Quiet -count 1){
            if (!(Stop-Computer -ComputerName $servname -Force)){
                Write-Host "$servname is Shuttingdown" -ForegroundColor Green
                $servname | Out-File ShutdownSVRs.txt -Append
            }else{
                Write-Host "Could not shutdown $servname" -ForegroundColor Red
                $servname | Out-File FailSVRs.txt -Append
            }   
          }else{
                Write-Host "Could not Connect to $servname" -ForegroundColor Red
                $servname | Out-File FailSVRs.txt -Append
          }
     }

 
    $ritzservers='TS1','POSSVR','EX1','DC1'
    $ritzcredentials= (Get-Credential ritz.local\administrator)
    foreach ($ritzsvr in $ritzservers)
    {
        Stop-Computer -ComputerName $ritzsvr -Force -Credential $ritzcredentials
    }
 

    Write-Host "============================================="
    Write-host "Sending results to itteam@camarketing.com..."
    Write-Host "============================================="
    $mail=Send-MailMessage -to "ITTEAM@CAMARKETING.COM"`
                      -From 'scriptoffserver@camarketing.local'`
                      -Subject 'SERVERS STATUS AFTER SHUTDOWN SCRIPT'`
                      -Body 'ATTACHED ARE THE LIST OF SHUTDOWN  AND FAIL TO SHUTDOWN SERVERS'`
                      -Attachments 'ShutdownSVRs.txt','FailSVRs.txt'`
                      -SmtpServer 'mail.camarketing.com'
    IF (!($mail)){
        Remove-Item FailSVRs.txt
        Remove-Item ShutdownSVRs.txt
    }else{
        Write-Host "The email could not be sent, please see the results in FailSVRs.txt and ShutdownSVRs.txt" -ForegroundColor Yellow
    }
}