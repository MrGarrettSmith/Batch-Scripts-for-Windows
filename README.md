# Batch Scripts for Windows
### Helpful batch scripts to optimize, declutter, configure settings and batch install programs in Windows!

* These scripts may need to be modified to suit specific needs.
* All scripts were created and tested on Windows 10.
* Each require to be ran as an Administrator.
* At launch, a brief prompt will require user input for confirmation.

## 🗈 Install Programs Unattended
If you've just installed a fresh copy of Windows, you probably have many programs that you need to install.<br>
The process of clicking through all of those installers can be exhausting...<br>
This script completely eliminates that tiresome and laborious process!

<img src="https://raw.githubusercontent.com/MrGarrettSmith/Batch-Scripts-for-Windows/main/_Screenshots/Install%20Programs%20Unattended.png" alt="" width="800"/><br>

* Modify the script and ensure it looks for the correct executibles.
* The commands use partial names to locate files.
* The script will look for files in the same directory.
* There are additional commands that are able to:
  * Terminate processes to ensure there are no interruptions.
  * Unarchive zip files.
  * Move configuration files to specific directories.
  * Delete desktop shortcuts from installers.

## 🗈 Uninstall Bundled Programs
Microsoft includes sponsored and bundled programs in the Home and Pro editions of their operating system.<br>
Unless you've installed an Enterprise version, there will be several unnecessary programs.<br>
Use this script to uninstall all of them at once!

<img src="https://raw.githubusercontent.com/MrGarrettSmith/Batch-Scripts-for-Windows/main/_Screenshots/Uninstall%20Bundled%20Programs.png" alt="" width="800"/>

* This script will work as is.
* There is an additional command to install winget in order to remove other programs.
* Some Windows Store apps may not be included in this script and may need to be manually added.
* To see all the Windows Stores apps installed, run Command Prompt as an Adminstrator and use this command:

```powershell Get-AppxPackage -AllUsers ^| Select Name, PackageFullName```


## 🗈 Set Windows Settings
Windows installs with many unwanted settings.<br>
Use this script to customize and configure Windows to your desired preferences in one go!

<img src="https://raw.githubusercontent.com/MrGarrettSmith/Batch-Scripts-for-Windows/main/_Screenshots/Set%20Windows%20Settings.png" alt="" width="800"/>

* This script will modify registry entries to configure Windows settings!
* Review the commands and ensure the preferred settings are configured.
