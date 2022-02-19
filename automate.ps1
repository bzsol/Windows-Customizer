Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

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

$isprogramming = Read-Host "Is it for programming? (y/n)"
# Choco installer
if ( $isprogramming -eq "y")
{
choco install git -y
choco install googlechrome -y
choco install firefox -y
choco install notepadplusplus -y
choco install 7zip -y
choco install teamviewer -y
choco install putty -y
choco install vscode -y
choco install k-litecodecpackfull -y
choco install winscp.install -y
choco install qbittorrent -y
choco install irfanview -y
choco install microsoft-windows-terminal -y
choco install python3 -y
choco install discord -y
choco install teamviewer -y
}
else{

}


