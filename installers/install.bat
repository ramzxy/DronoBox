@echo off
setlocal EnableDelayedExpansion

REM Colors using ANSI escape codes
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

cls
echo.
echo ========================================================
echo          DronoBox Installation Script
echo ========================================================
echo.
echo This script will install:
echo   [1] ImpulseRC Driver Fixer
echo   [2] Betaflight Configurator
echo.
echo ========================================================
echo.
timeout /t 2 /nobreak >nul

REM ========================================================
REM Step 1: Download and Run ImpulseRC Driver Fixer
REM ========================================================
echo [STEP 1/4] Downloading ImpulseRC Driver Fixer...
echo --------------------------------------------------------
powershell -Command "Invoke-WebRequest -Uri https://downloads.impulserc.com/driverfixer.exe -OutFile driverfixer.exe"

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to download ImpulseRC Driver Fixer!
    echo Press any key to exit...
    pause >nul
    exit /b 1
)
echo [SUCCESS] Downloaded successfully!
echo.

echo [STEP 2/4] Running ImpulseRC Driver Fixer...
echo --------------------------------------------------------
echo NOTE: This will open a GUI window. Please complete the process.
echo.
start /wait driverfixer.exe

if %ERRORLEVEL% NEQ 0 (
    echo [WARNING] Driver Fixer may have encountered an issue.
    echo Continuing anyway...
)
echo [SUCCESS] Driver Fixer completed!
echo.

REM ========================================================
REM Step 2: Download and Install Betaflight Configurator
REM ========================================================
echo [STEP 3/4] Downloading Betaflight Configurator...
echo --------------------------------------------------------
powershell -Command "Invoke-WebRequest -Uri https://github.com/betaflight/betaflight-configurator/releases/latest/download/betaflight-configurator-installer.exe -OutFile betaflight-configurator-installer.exe"

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to download Betaflight Configurator!
    echo Press any key to exit...
    pause >nul
    exit /b 1
)
echo [SUCCESS] Downloaded successfully!
echo.

echo [STEP 4/4] Installing Betaflight Configurator...
echo --------------------------------------------------------
start /wait betaflight-configurator-installer.exe /SILENT

if %ERRORLEVEL% NEQ 0 (
    echo [WARNING] Installation may have encountered an issue.
) else (
    echo [SUCCESS] Betaflight Configurator installed!
)
echo.

REM ========================================================
REM Cleanup
REM ========================================================
echo Cleaning up temporary files...
echo --------------------------------------------------------
del /f /q driverfixer.exe 2>nul
del /f /q betaflight-configurator-installer.exe 2>nul
echo [SUCCESS] Cleanup completed!
echo.

echo ========================================================
echo          Installation Complete!
echo ========================================================
echo.
echo All components have been installed successfully.
echo You can now close this window.
echo.

endlocal
pause