@echo off

@echo off

NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (

  echo Silent Program Installation Batch Script
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
  echo Silent Program Installation Batch Script
  echo Created by Garrett Smith
  echo Version 2023.10.18
  echo.
  echo [32mTested on Windows 10 Pro - Version 2H22 - Build 19045.3208[0m
  echo.

:: Displays the confirmation message
  echo [31mThis script will silently install several programs.[0m
  echo [31mThis script might take awhile to complete.[0m
  echo [31mThis script will automatically restart your computer once completed.[0m
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

echo Installing 7-Zip...
for /R %%G in (*7z*.msi) do msiexec.exe /i "%%G" /q INSTALLDIR="C:\Program Files\7-Zip"


echo Installing Google Chrome...
for /R %%G in (*chrome*.exe) do "%%G" /silent /install
::Deletes desktop shortcut
del /q "%PUBLIC%\Desktop\*google*.lnk"


echo Installing Carbonite Endpoint...
for /R %%G in (*dcprotect*.msi) do msiexec.exe /i "%%G" /qn

echo Terminating Carbonite Endpoint process...
::This is to close the window to keep the install "silent"
taskkill /IM "DCProtect.exe" /F
::Deletes desktop shortcut
del /q "%PUBLIC%\Desktop\*carbonite*.lnk"


echo Installing Deadlines AutoSync...
for /R %%G in (*deadlines*.msi) do "%%G" /quiet


echo Installing Dropbox...
for /R %%G in (*dropbox*.exe) do "%%G" /NOLAUNCH


echo Installing OpenShell...
for /R %%G in (*openshell*.exe) do "%%G" /quiet


echo Installing OpenShell Fluent Metro Skin...
::Unzips archive
powershell -Command "$zipFiles = Get-ChildItem -Recurse -Filter '*fluent*.zip'; foreach ($zipFile in $zipFiles) { $destinationFolder = Join-Path -Path $zipFile.Directory.FullName -ChildPath ($zipFile.BaseName); Add-Type -A 'System.IO.Compression.FileSystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile.FullName, $destinationFolder); }"
::Moves files
for /R %%F in (*fluent*\*.skin* *.skin7*) do move "%%F" "C:\Program Files\Open-Shell\Skins"


echo Installing Roboform...
for /R %%G in (*roboform*.msi) do "%%G" /quiet

echo Terminating Roboform process...
::This is to close the window to keep the install "silent"
taskkill /IM "robotaskbaricon.exe" /F

echo Terminating Microsoft Edge process...
::This is to close the window to keep the install "silent"
taskkill /IM "msedge.exe" /F
::Deletes Microsoft Edge desktop shortcut
del /q "%PUBLIC%\Desktop\*edge*.lnk"

echo Installing Speedtest by Ookla...
for /R %%G in (*speedtest*.msi) do "%%G" /qn


echo Installing VLC Media Player...
for /R %%G in (*vlc*.exe) do "%%G" /S
::Deletes desktop shortcut
del /q "%PUBLIC%\Desktop\*vlc*.lnk"


echo Installing Vonage Business...
for /R %%G in (*vonage*.msi) do msiexec /i "%%G" /qn /norestart


echo Installing Zoom...
for /r "%~dp0" %%i in (*zoom*.msi) do (start /wait msiexec /i "%%~fi" /quiet zRecommend="AU2_EnableAutoUpdate=1;AU2_SetUpdateChannel=0;AU2_EnableShowZoomUpdates=1;AU2_EnableUpdateAvailableBanner=1;AU2_EnableManualUpdate=1")
::Deletes desktop shortcut
del /q "%PUBLIC%\Desktop\*zoom*.lnk"


echo Installing Adobe Acrobat Pro DC...
::Unzips archive
powershell -Command "$zipFiles = Get-ChildItem -Recurse -Filter '*adobe*.zip'; foreach ($zipFile in $zipFiles) { $destinationFolder = Join-Path -Path $zipFile.Directory.FullName -ChildPath ($zipFile.BaseName); Add-Type -A 'System.IO.Compression.FileSystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile.FullName, $destinationFolder); }"
::Installs Adobe Acrobat Pro DC
"Adobe Acrobat Pro DC_en_US_WIN_64\Adobe Acrobat Pro DC\Build\setup.exe" --silent
::Deletes desktop shortcut
del /q "%PUBLIC%\Desktop\*adobe*.lnk"
echo.

echo Installing DisplayLink drivers (for VisionTek dock)...
"DisplayLink USB Graphics Software for Windows11.2 M0-EXE.exe" -silent -noreboot


echo Installing Microsoft 365...
::Downloads, installs, and configures Microsoft 365
setup.exe /download Office365.xml
setup.exe /configure Office365.xml

echo Installing Visual Studio Tools 2010 for Office Runtime...
::This is required for NetDocuments software
for /R %%G in (*vstor*.exe) do "%%G" /quiet


echo Installing NDOffice...
::Unzips archive
powershell -Command "$zipFiles = Get-ChildItem -Recurse -Filter '*ndoffice*.zip'; foreach ($zipFile in $zipFiles) { $destinationFolder = Join-Path -Path $zipFile.Directory.FullName -ChildPath ($zipFile.BaseName); Add-Type -A 'System.IO.Compression.FileSystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile.FullName, $destinationFolder); }"
::Installs NDOffice
start /wait msiexec /i "ndOfficeSetup\ndOfficeSetup.msi" /quiet

echo Installing NDAdobe...
ndOfficeSetup\ndOfficeAdobeSetupX64.msi /quiet


echo Installing NDMail...
::Unzips archive
powershell -Command "$zipFiles = Get-ChildItem -Recurse -Filter '*ndmail*.zip'; foreach ($zipFile in $zipFiles) { $destinationFolder = Join-Path -Path $zipFile.Directory.FullName -ChildPath ($zipFile.BaseName); Add-Type -A 'System.IO.Compression.FileSystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile.FullName, $destinationFolder); }"
::Installs NDMail
ndMailSetup\ndMailSetup.msi /quiet
::Installs NDMail Folder Mapping
ndMailSetup\"ndMail Folder Mapping x64".msi /quiet


echo Installing HID 4500 Fingerprint Scanner drivers...
::Unzips HID 4500 Fingerprint Scanner driver files
powershell -Command "$zipFiles = Get-ChildItem -Recurse -Filter '*4500*.zip'; foreach ($zipFile in $zipFiles) { $destinationFolder = Join-Path -Path $zipFile.Directory.FullName -ChildPath ($zipFile.BaseName); Add-Type -A 'System.IO.Compression.FileSystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile.FullName, $destinationFolder); }"
::Installs HID 4500 Fingerprint Scanner drivers - causes a restart
4500_wbf_driver_5.0.0.5_rs3\setup\setup64.exe /S /v/qn

echo.

echo All tasks have finished.

pause