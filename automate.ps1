# Set-ExecutionPolicy Unrestricted -Force

$ischangepcname = Read-Host "PC name change? (y/n)"
if($ischangepcname -eq "y"){
	$PCNAME = Read-Host "Please enter your PC name: "
	Rename-Computer -NewName $PCNAME
}
$isdnschange = Read-Host "Change your DNS? (y/n)"
if($isdnschange -eq "y"){
 Get-NetIPConfiguration
 $INDEX = Read-Host "Interface Index: "
 Set-DnsClientServerAddress -InterfaceIndex $INDEX -ServerAddresses 1.1.1.1, 8.8.8.8
 Write-Host "DNS change has been done!"
}

Write-Host "Show hidden file extensions and hidden files as well!"
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden -Value 1
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Value 0

Write-Host "Installing Chocolatey for installing the programs that needed for the user..."
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

$isforprogramming = Read-Host "Is it for programming? (y/n)"

if($isforprogramming -eq "y"){
	choco install googlechrome -y
	choco install firefox -y
	choco install 7zip -y
	choco install vscode -y
	choco install git -y
	choco install steam-client -y
	choco install discord -y
	choco install k-litecodecpackfull -y
	choco install postman -y
	choco install visualstudio2022community -y
	choco install qbittorrent -y
	choco install irfanview -y
	choco install teamviewer -y
	choco install obs-studio -y
	choco install sumatrapdf -y
	choco install nodejs -y
	choco install microsoft-windows-terminal -y
	choco install arduino -y
	choco install winscp -y
	choco install jdk11 -y
	choco install teamspeak -y
	choco install revo-uninstaller -y
}
else{

}
if([System.Environment]::OSVersion.Version.Major -eq 10){
	Write-Host "Windows 10 Debloater"
	Invoke-WebRequest -useb https://git.io/debloat | Invoke-Expression
}
elseif([System.Environment]::OSVersion.Version.Major -eq 11){
    Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
	scoop bucket add extras
	scoop install thisiswin11
}
else{
	Write-Error "You are using an old Windows system!"
}



