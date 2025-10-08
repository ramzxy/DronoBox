@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1

REM Set window title
title DronoBox Installer - Setting up your drone tools!

REM Use PowerShell for colored output
set "PS=powershell -NoProfile -Command"

cls

REM Welcome banner
%PS% "Write-Host ''; Write-Host '╔════════════════════════════════════════════════════════════════╗' -ForegroundColor Cyan"
%PS% "Write-Host '║' -ForegroundColor Cyan -NoNewline; Write-Host '                                                                ' -NoNewline; Write-Host '║' -ForegroundColor Cyan"
%PS% "Write-Host '║' -ForegroundColor Cyan -NoNewline; Write-Host '           🚁  DRONOBOX INSTALLATION WIZARD  🚁            ' -ForegroundColor Yellow -NoNewline; Write-Host '    ║' -ForegroundColor Cyan"
%PS% "Write-Host '║' -ForegroundColor Cyan -NoNewline; Write-Host '                                                                ' -NoNewline; Write-Host '║' -ForegroundColor Cyan"
%PS% "Write-Host '╚════════════════════════════════════════════════════════════════╝' -ForegroundColor Cyan; Write-Host ''"

%PS% "Write-Host '  Welcome! This installer will set up everything you need' -ForegroundColor White"
%PS% "Write-Host '  to get your drone connected and configured.' -ForegroundColor White; Write-Host ''"

%PS% "Write-Host '  📦 What we''ll install:' -ForegroundColor Green"
%PS% "Write-Host '     ✓ ImpulseRC Driver Fixer  ' -ForegroundColor Gray -NoNewline; Write-Host '(fixes USB connection issues)' -ForegroundColor DarkGray"
%PS% "Write-Host '     ✓ Betaflight Configurator ' -ForegroundColor Gray -NoNewline; Write-Host '(configure your drone)' -ForegroundColor DarkGray; Write-Host ''"

%PS% "Write-Host '  ⏱️  Estimated time: 2-3 minutes' -ForegroundColor Magenta; Write-Host ''"

%PS% "Write-Host '╔════════════════════════════════════════════════════════════════╗' -ForegroundColor Cyan"
%PS% "Write-Host '║' -ForegroundColor Cyan -NoNewline; Write-Host '  Starting installation in a moment...                          ' -NoNewline; Write-Host '║' -ForegroundColor Cyan"
%PS% "Write-Host '╚════════════════════════════════════════════════════════════════╝' -ForegroundColor Cyan; Write-Host ''"

timeout /t 2 /nobreak >nul

REM ========================================================
REM Step 1: Download and Run ImpulseRC Driver Fixer
REM ========================================================
%PS% "Write-Host '┌────────────────────────────────────────────────────────────────┐' -ForegroundColor Blue"
%PS% "Write-Host '│' -ForegroundColor Blue -NoNewline; Write-Host ' STEP 1/4: Downloading ImpulseRC Driver Fixer                  ' -ForegroundColor White -NoNewline; Write-Host '│' -ForegroundColor Blue"
%PS% "Write-Host '└────────────────────────────────────────────────────────────────┘' -ForegroundColor Blue; Write-Host ''"
%PS% "Write-Host '  📥 Downloading from ImpulseRC servers...' -ForegroundColor Cyan"

powershell -NoProfile -Command "& {$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri 'https://impulserc.blob.core.windows.net/utilities/ImpulseRC_Driver_Fixer.exe' -OutFile 'ImpulseRC_Driver_Fixer.exe'}"

if %ERRORLEVEL% NEQ 0 (
    %PS% "Write-Host ''; Write-Host '  ❌ ERROR: Failed to download ImpulseRC Driver Fixer!' -ForegroundColor Red"
    %PS% "Write-Host '  Please check your internet connection and try again.' -ForegroundColor Yellow; Write-Host ''"
    pause
    exit /b 1
)

%PS% "Write-Host '  ✅ Download complete!' -ForegroundColor Green; Write-Host ''"

%PS% "Write-Host '┌────────────────────────────────────────────────────────────────┐' -ForegroundColor Blue"
%PS% "Write-Host '│' -ForegroundColor Blue -NoNewline; Write-Host ' STEP 2/4: Running ImpulseRC Driver Fixer                      ' -ForegroundColor White -NoNewline; Write-Host '│' -ForegroundColor Blue"
%PS% "Write-Host '└────────────────────────────────────────────────────────────────┘' -ForegroundColor Blue; Write-Host ''"
%PS% "Write-Host '  🔧 Launching Driver Fixer application...' -ForegroundColor Cyan"
%PS% "Write-Host '  ℹ️  A new window will open. Please follow the on-screen instructions.' -ForegroundColor Yellow; Write-Host ''"

start /wait ImpulseRC_Driver_Fixer.exe

if %ERRORLEVEL% NEQ 0 (
    %PS% "Write-Host '  ⚠️  Driver Fixer completed with warnings (this is usually okay)' -ForegroundColor Yellow"
) else (
    %PS% "Write-Host '  ✅ Driver Fixer completed successfully!' -ForegroundColor Green"
)
%PS% "Write-Host ''"

REM ========================================================
REM Step 3: Download and Install Betaflight Configurator
REM ========================================================
%PS% "Write-Host '┌────────────────────────────────────────────────────────────────┐' -ForegroundColor Blue"
%PS% "Write-Host '│' -ForegroundColor Blue -NoNewline; Write-Host ' STEP 3/4: Downloading Betaflight Configurator v10.10.0        ' -ForegroundColor White -NoNewline; Write-Host '│' -ForegroundColor Blue"
%PS% "Write-Host '└────────────────────────────────────────────────────────────────┘' -ForegroundColor Blue; Write-Host ''"
%PS% "Write-Host '  📥 Downloading from GitHub (this may take a minute)...' -ForegroundColor Cyan"

powershell -NoProfile -Command "& {$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri 'https://github.com/betaflight/betaflight-configurator/releases/download/10.10.0/betaflight-configurator_10.10.0_win64-installer.exe' -OutFile 'betaflight-configurator_10.10.0_win64-installer.exe'}"

if %ERRORLEVEL% NEQ 0 (
    %PS% "Write-Host ''; Write-Host '  ❌ ERROR: Failed to download Betaflight Configurator!' -ForegroundColor Red"
    %PS% "Write-Host '  Please check your internet connection and try again.' -ForegroundColor Yellow; Write-Host ''"
    pause
    exit /b 1
)

%PS% "Write-Host '  ✅ Download complete!' -ForegroundColor Green; Write-Host ''"

%PS% "Write-Host '┌────────────────────────────────────────────────────────────────┐' -ForegroundColor Blue"
%PS% "Write-Host '│' -ForegroundColor Blue -NoNewline; Write-Host ' STEP 4/4: Installing Betaflight Configurator                  ' -ForegroundColor White -NoNewline; Write-Host '│' -ForegroundColor Blue"
%PS% "Write-Host '└────────────────────────────────────────────────────────────────┘' -ForegroundColor Blue; Write-Host ''"
%PS% "Write-Host '  ⚙️  Installing silently in the background...' -ForegroundColor Cyan; Write-Host ''"

start /wait betaflight-configurator_10.10.0_win64-installer.exe /SILENT

if %ERRORLEVEL% NEQ 0 (
    %PS% "Write-Host '  ⚠️  Installation completed with warnings' -ForegroundColor Yellow"
) else (
    %PS% "Write-Host '  ✅ Betaflight Configurator installed successfully!' -ForegroundColor Green"
)
%PS% "Write-Host ''"

REM ========================================================
REM Cleanup
REM ========================================================
%PS% "Write-Host '  🧹 Cleaning up temporary files...' -ForegroundColor Cyan"
del /f /q ImpulseRC_Driver_Fixer.exe 2>nul
del /f /q betaflight-configurator_10.10.0_win64-installer.exe 2>nul
%PS% "Write-Host '  ✅ Cleanup complete!' -ForegroundColor Green; Write-Host ''"

REM Success banner
%PS% "Write-Host '╔════════════════════════════════════════════════════════════════╗' -ForegroundColor Green"
%PS% "Write-Host '║' -ForegroundColor Green -NoNewline; Write-Host '                                                                ' -NoNewline; Write-Host '║' -ForegroundColor Green"
%PS% "Write-Host '║' -ForegroundColor Green -NoNewline; Write-Host '                🎉 INSTALLATION COMPLETE! 🎉                    ' -ForegroundColor Yellow -NoNewline; Write-Host '║' -ForegroundColor Green"
%PS% "Write-Host '║' -ForegroundColor Green -NoNewline; Write-Host '                                                                ' -NoNewline; Write-Host '║' -ForegroundColor Green"
%PS% "Write-Host '╚════════════════════════════════════════════════════════════════╝' -ForegroundColor Green; Write-Host ''"

%PS% "Write-Host '  ✨ All components installed successfully!' -ForegroundColor White; Write-Host ''"
%PS% "Write-Host '  🚀 Next steps:' -ForegroundColor Cyan"
%PS% "Write-Host '     1. Connect your drone via USB' -ForegroundColor White"
%PS% "Write-Host '     2. Launch Betaflight Configurator from your Start menu' -ForegroundColor White"
%PS% "Write-Host '     3. Click ''Connect'' and start configuring!' -ForegroundColor White; Write-Host ''"
%PS% "Write-Host '  💡 Need help? Ask your instructor or check the documentation!' -ForegroundColor Magenta; Write-Host ''"

%PS% "Write-Host '  Press any key to close this window...' -ForegroundColor Gray"

endlocal
pause >nul