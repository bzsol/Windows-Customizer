# Set-ExecutionPolicy Unrestricted -Force

$ischangepcname = Read-Host "PC name change? (y/n)"
if($ischangepcname -eq "y"){
	$PCNAME = Read-Host "Please enter your PC name: "
	Rename-Computer -NewName $PCNAME
}
$isdnschange = Read-Host "Change your DNS? (y/n)"
if($isdnschange -eq "y"){
	Get-NetAdapter -Name * -Physical
	Get-NetRoute | ForEach-Object { Process { If (!$_.RouteMetric) { $_.ifIndex } } };
	# 1.1.1.2 when you want to block malware and also 1.0.0.2 for kids you should use: 1.1.1.3 or 1.0.0.3
	# https://1.1.1.1/family/
	Set-DNSClientServerAddress -interfaceIndex $intix -ServerAddresses ("1.1.1.1","1.0.0.1");
	Write-Host "DNS change has been done!"
}

Write-Host "Show hidden file extensions and hidden files as well!"
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden -Value 1
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Value 0

Write-Host "Disable Hibernate mode to free 50GB space"
powercfg.exe -h off
Write-Host "Turn off Indexing"
Set-Content stop "wsearch" 
Set-Content config "wsearch" start=disabled

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
	choco install googlechrome
	choco install firefox 
	choco install revo-uninstaller
	choco install steam-client 
	choco install discord
	choco install teamviewer
	choco install vlc
	choco install 7zip
	choco install winrar
	choco install javaruntime 
	choco install brave
	choco install irfanview
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
# Determine what exact components the computer has.
Write-Host "Components:"
Get-WmiObject win32_VideoController | Format-List Name
Get-WmiObject win32_Processor | Format-List Name

