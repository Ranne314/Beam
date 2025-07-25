@echo off
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

echo Uninstalling Beam...

:: Define paths
SET "beamPath=%ProgramFiles%\Beam"
SET "launcherPath=%beamPath%\beam.bat"
SET "shortcutPath=%USERPROFILE%\Desktop\Beam.lnk"
SET "iconPath=%beamPath%\beam.ico"

:: Delete launcher
IF EXIST "!launcherPath!" (
    del /f /q "!launcherPath!"
    echo Removed launcher script.
)

:: Delete app.py
IF EXIST "!beamPath!\app.py" (
    del /f /q "!beamPath!\app.py"
    echo Removed app.py.
)

:: Delete icon
IF EXIST "!iconPath!" (
    del /f /q "!iconPath!"
    echo Removed icon file.
)

:: Remove Beam folder if empty
rd "!beamPath!" >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Beam directory removed.
) ELSE (
    echo Beam directory not empty or couldn't be removed.
)

:: Delete desktop shortcut
IF EXIST "!shortcutPath!" (
    del /f /q "!shortcutPath!"
    echo Removed desktop shortcut.
)

echo ✅ Beam has been fully uninstalled.
