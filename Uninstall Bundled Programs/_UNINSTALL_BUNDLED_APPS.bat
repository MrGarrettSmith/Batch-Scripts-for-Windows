@echo off

NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (

  echo Bundled Windows Store Apps + Programs Uninstallation Script
  echo Created by Garrett Smith
  echo Version 2023.10.18
  echo.
  echo [32mTested on Windows 10 Pro - Version 2H22 - Build 19045.3208[0m
  echo.
  echo [31mThis script requires administrative privileges.[0m
  echo [31mPlease run as administrator.[0m
  echo.
  pause
  exit /b 1
)

:: Displays the Script heading.
  echo Bundled Windows Store Apps + Programs Uninstallation Script
  echo Created by Garrett Smith
  echo Version 2023.10.18
  echo.
  echo [32mTested on Windows 10 Pro - Version 2H22 - Build 19045.3208[0m
  echo.

:: Displays the confirmation message
  echo [31mThis script will uninstall several bundled Windows Store Apps.[0m
  echo.
  echo To proceed, type Y and press Enter.
  echo To cancel, type N and press Enter.
  echo.

:: Prompt the user for input (Y/N)
set /p "choice=Your choice (Y/N): "

:: Check the user's input
if /i "%choice%"=="Y" (
  echo Proceeding with script operations...
) else (
  if /i "%choice%"=="N" (
    echo.
    echo Script execution cancelled.
    echo.
    pause
    exit /b 0
  ) else (
    echo Invalid choice. Script execution cancelled.
    pause
    exit /b 1
  )
)

cd /d "%~dp0"

echo.
echo.
echo WINDOWS STORE APPS
echo.

echo Uninstalling "3D Viewer"...
powershell.exe -Command "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"

echo Uninstalling "Feedback Hub"...
powershell.exe -Command "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"

echo Uninstalling "Groove Music"...
powershell.exe -Command "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage"

echo Uninstalling "Killer Control Center"...
powershell.exe -Command "Get-AppxPackage *RivetNetworks.KillerControlCenter* | Remove-AppxPackage"

echo Uninstalling "Mail"...
powershell.exe -Command "Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage"

echo Uninstalling "Maps"...
powershell.exe -Command "Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage"

echo Uninstalling "Messaging"...
powershell.exe -Command "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"

echo Uninstalling "Microsoft 365 (Office)"...
powershell.exe -Command "Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"

echo Uninstalling "Mixed Reality Portal"...
powershell.exe -Command "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage"

echo Uninstalling "Movies & TV"...
powershell.exe -Command "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage"

echo Uninstalling "Microsoft.OneConnect"...
powershell.exe -Command "Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage"

echo Uninstalling "OneDrive"...
powershell.exe -Command "Get-AppxPackage *microsoft.microsoftskydrive* | Remove-AppxPackage"

echo Uninstalling "OneNote for Windows 10"...
powershell.exe -Command "Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage"

echo Uninstalling "Phone Link"...
powershell.exe -Command "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"

echo Uninstalling "Skype"...
powershell.exe -Command "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage"

echo Uninstalling "Solitaire & Casual Games"...
powershell.exe -Command "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"

echo Uninstalling "Spotify"...
powershell.exe -Command "Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage"

echo Uninstalling "Sticky Notes"...
powershell.exe -Command "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"

echo Uninstalling "Tips"...
powershell.exe -Command "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"

echo Uninstalling "Weather"...
powershell.exe -Command "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage"

echo Uninstalling "Whiteboard"...
powershell.exe -Command "Get-AppxPackage *Microsoft.Whiteboard* | Remove-AppxPackage"

echo Uninstalling "Xerox Print and Scan Experience"...
powershell.exe -Command "Get-AppxPackage *XeroxCorp.PrintExperience* | Remove-AppxPackage"

echo Uninstalling "Xbox Console Companion"...
powershell.exe -Command "Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage"
echo.
echo.

echo WINDOWS PROGRAMS
echo.

echo Installing Winget...
curl -o %temp%\winget_installer.msixbundle -L https://github.com/microsoft/winget-cli/releases/download/v1.7.2782-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
powershell -command "Add-AppxPackage -Path %temp%\winget_installer.msixbundle"

echo Uninstalling "Dell Digital Delivery"...
winget uninstall {7B2D0B6F-F02D-4363-ACDF-00DE6247ACBC} --accept-source-agreements

echo Uninstalling "Xerox Print and Scan Experience"...
winget uninstall XeroxCorp.PrintExperience_f7egpvdyrs2a8 --accept-source-agreements

echo All tasks have finished.

pause