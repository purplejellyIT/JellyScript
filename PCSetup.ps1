Set-ExecutionPolicy remotesigned
function SetPCName {
    Add-Type -AssemblyName Microsoft.VisualBasic
    $ComputerName = [Microsoft.VisualBasic.Interaction]::InputBox('Enter desired Computer Name', 'Computer Name')
    Rename-Computer -NewName "$ComputerName"
}

function InstallChoco {
            # Ask for elevated permissions if required
    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
        Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        Exit
    }    
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco install adobereader googlechrome -y
    choco install microsoft-office-deployment --params="'/Channel:Monthly /Language:en-us /64bit /Product:O365BusinessRetail /Exclude:Lync,Groove'" -y
}


function AutomateInstall{
msiexec /i c:\PurpleJelly\PurpleJelly-DeviceSetup-main\Agent_Install.msi /qn /lv c:\PurpleJelly\agent_install_log.txt
}

function DisableFastStartup{
powercfg -h off
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V HiberbootEnabled /T REG_dWORD /D 0 /F
}

function PoolTimeSync{
w32TM /config /syncfromflags:manual /manualpeerlist:uk.pool.ntp.org
w32tm /config /update
w32tm /resync
}

function Bitlocker{
Start-Process "cmd.exe" "/c C:\PurpleJelly\PurpleJelly-DeviceSetup-main\BitlockerConfigurator.bat"
}


SetPCName
InstallChoco
DisableFastStartup
PoolTimeSync
AutomateInstall
Bitlocker


