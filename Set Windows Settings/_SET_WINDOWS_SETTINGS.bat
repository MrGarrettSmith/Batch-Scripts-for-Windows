@echo off

NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (

  echo Windows 10 Settings App Batch Script
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

:: Display the Script heading.
  echo Windows 10 Settings App Batch Script
  echo Created by Garrett Smith
  echo Version 2023.10.18
  echo.
  echo [32mTested on Windows 10 Pro - Version 2H22 - Build 19045.3208[0m
  echo.

:: Display the confirmation message
  echo [31mThis script will set options in the Windows Settings app.[0m
  echo [31mThis script will modify the Windows Registry to set these options.[0m
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

echo.
echo.
echo UPDATE AND SECURITY
echo.
echo.
echo DELIVERY OPTIMIZATION

echo [31mDisabling "Allow downloads from other PCs"[0m
reg add "HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v DownloadMode /t REG_DWORD /d 0 /f

echo.
echo.
echo PRIVACY
echo.
echo.

echo GENERAL

echo [31mDisabling "Let apps use advertising ID to make ads more interesting to you based on your app activity (Turning this off will reset your ID.)"[0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f

echo [31mDisabling "Let websites provide locally relevant content by accessing my language"[0m
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f

echo [31mDisabling "Let Windows track app launches to improve Start and search results"[0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f

echo [31mDisabling "Show me suggested content in the Settings app"[0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f

echo.
echo.
echo SPEECH

echo [31mDisabling "Online Speech Recognition"[0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v AllowInputPersonalization /t REG_DWORD /d 0 /f

echo.
echo INKING AND TYPING PERSONALIZATION

echo [31mDisabling "Use your typing history and handwriting patterns to create a personal dictionary that makes better suggestions for you."[0m
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f

echo [31mSetting color for "default Windows mode" to "Dark"[0m
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

echo [31Unpinning the "Meet Now" icon from the System Tray[0m
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V HideSCAMeetNow /T REG_DWORD /D 1 /F
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V HideSCAMeetNow /T REG_DWORD /D 1 /F

::The next 4 registry edits require a restart of Windows Explorer

echo [31mEnabling "Always show all icons in the notification area"[0m
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F

echo [31Disabling "Show News and Interestes on the taskbar"[0m
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f

echo [31Hiding the Task View button from the taskbar[0m
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AllUpView" /V Enabled /F
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V ShowTaskViewButton /T REG_DWORD /D 0 /F

echo [31Setting the task bar "Search" to "Hidden"[0m
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /V SearchboxTaskbarMode /T REG_DWORD /D 0 /F

echo [31mRestarting Windows Explorer...[0m
taskkill /f /im explorer.exe
start explorer.exe

echo.
echo DIAGNOSTICS AND FEEDBACK

echo [31mSetting Diagnostic data to "Required diagnostic data"[0m
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v ShowedToastAtLevel /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v MaxTelemetryAllowed /t REG_DWORD /d 1 /f

echo [31mDisabling "Tailored Experiences"[0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f

echo [31mDisabling "View diagnostic data"[0m
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" /v EnableEventTranscript /t REG_DWORD /d 0 /f

echo [31mSetting "Feedback frequency" to "Never"[0m
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v PeriodInNanoSeconds /t REG_BINARY /d 0000000000000000 /f

echo.
echo ACTIVITY HISTORY

echo [31mDisabling "Store my activity on this device"[0m
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f

echo.
echo LOCATION

echo [31mEnabling "Allow access to location on this device"[0m
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d "Allow" /f

echo [31mEnabling "Allow apps to access your location"[0m
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location\NonPackaged" /v Value /t REG_SZ /d "Allow" /f

echo.
echo VOICE ACTIVATION

echo [31mDisabling "Allow apps to use voice activation"[0m
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v AgentActivationEnabled /t REG_DWORD /d 0 /f

echo [31mDisabling "Allow apps to use voice activation when this device is locked"[0m
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v AgentActivationOnLockScreenEnabled /t REG_DWORD /d 0 /f

echo [31mDisabling "Choose your default app for headset button press"[0m
reg add "HKCU\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v AgentActivationLastUsed /t REG_DWORD /d 0 /f

echo.
echo.
echo EASE OF ACCESS
echo.
echo.

echo KEYBOARD

echo [31mDisabling "Press one key at a time to start Sticky Keys"[0m
echo [31mDisabling "Turn on Sticky Keys when SHIFT is pressed five times"[0m
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /V "Flags" /T REG_SZ /D "482" /F

echo [31mDisabling "Play a sound whenever you press Caps Lock, Num Lock, or Scroll Lock"[0m
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v Flags /t REG_SZ /d "34" /f

echo [31mDisabling "Ignore brief or repeated keystrokes and change keyboard repeat rates"[0m
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v Flags /t REG_SZ /d "98" /f

echo.
echo NARRATOR

echo [31mDisabling "Allow shortcut key to start Narrator"[0m
reg add "HKCU\Software\Microsoft\Narrator\NoRoam" /v WinEnterLaunchEnabled /t REG_DWORD /d 0 /f

echo [31mDisabling "Minimize Narrator Home to System Tray"[0m
reg add "HKCU\SOFTWARE\Microsoft\Narrator\NarratorHome" /v MinimizeType /t REG_DWORD /d 1 /f

echo.
echo.
echo GAMING
echo.

echo.
echo XBOX GAME BAR

echo [31mDisabling "Enable Xbox Game Bar for..."[0m
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f

echo [31mDisabling "Open Xbox Game Bar using this button on a controller"[0m
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0 /f

echo.
echo.
echo DEVICES
echo.

echo.
echo PRINTERS AND SCANNERS

echo [31mDisabling "Let Windows manage my default printer"[0m
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v LegacyDefaultPrinterMode /t REG_DWORD /d 1 /f

echo.
echo AUTOPLAY

echo [31mSetting Removable drive option to "Open folder to view files (File Explorer)"[0m
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\StorageOnArrival" /ve /d "MSOpenFolder" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\StorageOnArrival" /ve /d "MSOpenFolder" /f

echo [31mSetting Memory card option to "Open folder to view files (File Explorer)"[0m
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\EventHandlersDefaultSelection\CameraAlternate\ShowPicturesOnArrival" /ve /d "MSOpenFolder" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\CameraAlternate\ShowPicturesOnArrival" /ve /d "MSOpenFolder" /f

echo.
echo All tasks have finished.
echo.

pause