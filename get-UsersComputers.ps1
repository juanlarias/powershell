fuction my-getuserloggedon{
    [CmdLetBinding()]
    Param(
        [Parameter(Mandatory=$false)]
                    [string]$username,
    
        [Parameter(Mandatory=$false)]
                    [switch]$verbose         
    )

    begin{
        $prop=@{}
        $obj=@{}
    }
    Process{
        Get-ADComputer -Filter * | ? {$_.DistinguishedName -like "*ou=Computers,*"}| ForEach-Object{
        $compname=$_
        if(!($username)){
                $obj=gwmi -ComputerName $compname.name Win32_ComputerSystem
                $prop.Computer=$obj.name
                $prop.Username=$obj.username
                New-Object -TypeName PSObject -Property $prop | Format-Table -AutoSize            
         }else{
                if ($verbose){
                write-host "Connecting ($compname.name)" -BackgroundColor Green}
                if (MytestConnection -ComputerName $compname.name){
                        $obj=gwmi -ComputerName $compname.name Win32_ComputerSystem | Where-Object {$_.username -like "domain\$username"} | select name,username
                        if ($obj){    
                            $prop.Computer=$obj.name
                            $prop.Username=$obj.username
                            New-Object -TypeName PSObject -Property $prop
                            exit
                        }
            
                    }else{
                        Write-Host "Unable to connect to ($compname.name)" -ForegroundColor Red
                    }
          }
        }
    
    }
}
