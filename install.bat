@echo off
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:: Check for Python
python --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Python is already installed.
    GOTO ContinueInstall
)

:: Python not found — ask user
CHOICE /M "Python not found. Do you want to install it?"
IF ERRORLEVEL 2 (
    echo Installation canceled by user.
    EXIT /B 0
)

:: Install Python using winget
echo Installing Python via winget...
winget install --id=Python.Python.3 --silent --accept-package-agreements --accept-source-agreements

:ContinueInstall
:: Create Beam directory
SET "beamPath=%ProgramFiles%\Beam"
IF NOT EXIST "!beamPath!" (
    mkdir "!beamPath!"
)

:: Copy app.py
IF EXIST src\app.py (
    copy src\app.py "!beamPath!\app.py"
)

:: Create launcher batch file
SET "launcher=!beamPath!\beam.bat"
(
    echo @echo off
    echo python "!beamPath!\app.py" %%*
) > "!launcher!"

:: Create desktop shortcut using PowerShell
SET "shortcutName=Beam.lnk"
SET "desktopPath=%USERPROFILE%\Desktop\!shortcutName!"
powershell -Command ^
  "$s=(New-Object -COM WScript.Shell).CreateShortcut('!desktopPath!'); ^
   $s.TargetPath='!launcher!'; ^
   $s.IconLocation='!beamPath!\beam.ico'; ^
   $s.Save()"

echo Shortcut created on Desktop. Beam is ready to launch!
