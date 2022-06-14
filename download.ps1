Set-ExecutionPolicy remotesigned
function downloadbuilder {
Invoke-WebRequest -Uri "https://github.com/purplejellyIT/DeviceSetup/archive/refs/heads/main.zip" -OutFile "C:\PurpleJelly\PJDeviceSetup.zip"
Expand-Archive C:\PurpleJelly\PJDeviceSetup.zip -DestinationPath C:\PurpleJelly\
}
downloadbuilder