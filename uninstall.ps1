$RegistryLocation = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\',
                            'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\'



#$soft=Get-WmiObject -class Win32_Product -ComputerName amazaonshaq | Where-Object {$_.vendor -like '*Oracle*'} | select name,vendor
<#

Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* |`
                 Where-Object {$_.DisplayName -like '*Po*'} |`
                  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize
                  #>

#Restart-Service -Name Spooler
Invoke-Command -ScriptBlock {Restart-Service -Name Spooler} -RunAsAdministrator 