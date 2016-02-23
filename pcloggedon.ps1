
function pcloggedon{
    [CmdLetBinding()]
    param(
        [parameter(mandatory=$true)]
        [string[]]$computername

    )
    foreach($computer in $computername){
        Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computer | select username
    }
}