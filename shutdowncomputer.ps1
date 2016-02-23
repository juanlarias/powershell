
    [CmdLetBinding()]
    Param(
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$hostname
    )
    $hostname=read-host "Enter one or more computer names separated by commas"
    if($hostname){
        if (Test-Connection -computername $hostname -Quiet -count 1){
            if (!(Stop-Computer -ComputerName $hostname -Force)){
                Write-Host "$hostname is Shuttingdown" -ForegroundColor Green
            }else{
                Write-Host "Could not shutdown $hostname" -ForegroundColor Red
            }   
          }else{
                Write-Host "Could not Connect to $hostname" -ForegroundColor Red
          }
        }else{
            write-host "hostname cannot be empty" -ForegroundColor Yellow
        }
            
          