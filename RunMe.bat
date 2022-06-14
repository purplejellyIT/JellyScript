mkdir c:\PurpleJelly
Powershell.exe -Command "& {Start-Process Powershell.exe -ArgumentList 'set-executionpolicy remotesigned' -Verb RunAs}"
powershell.exe -ExecutionPolicy Bypass -noprofile -command "&{start-process powershell -ArgumentList '-noprofile -file \"%~dp0download.ps1\"' -verb RunAs}"
timeout 30
powershell.exe -ExecutionPolicy Bypass -noprofile -command "&{start-process powershell -ArgumentList '-noprofile -file \"c:\PurpleJelly\DeviceSetup-main\PCSetup.ps1\"' -verb RunAs}"
