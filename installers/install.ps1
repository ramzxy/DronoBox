# DronoBox Installation Script for Windows
# Run this with: iwr -useb https://raw.githubusercontent.com/ramzxy/DronoBox/main/installers/install.ps1 | iex

$ErrorActionPreference = "Stop"
$host.ui.RawUI.WindowTitle = "DronoBox Installer - Setting up your drone tools!"

Clear-Host

# Function to center text
function Write-Centered {
    param([string]$Text, [string]$Color = "White")
    $width = $host.UI.RawUI.WindowSize.Width
    $padding = [Math]::Max(0, [Math]::Floor(($width - $Text.Length) / 2))
    Write-Host (" " * $padding + $Text) -ForegroundColor $Color
}

# Welcome banner with centered ASCII art
Write-Host ""
Write-Centered "    ____                        ____            " "Cyan"
Write-Centered "   / __ \_________  ____  ____ / __ )____  _  __" "Cyan"
Write-Centered "  / / / / ___/ __ \/ __ \/ __ \/ __  / __ \| |/_/" "Cyan"
Write-Centered " / /_/ / /  / /_/ / / / / /_/ / /_/ / /_/ />  <  " "Cyan"
Write-Centered "/_____/_/   \____/_/ /_/\____/_____/\____/_/|_|  " "Cyan"
Write-Host ""
Write-Centered "=================================================================" "Yellow"
Write-Centered "            INSTALLATION WIZARD - Drone Tools Setup             " "Yellow"
Write-Centered "=================================================================" "Yellow"
Write-Host ""



Write-Host ""
Write-Host ""
Write-Centered "Welcome! This installer will set up everything you need" "White"
Write-Centered "to get your drone connected and configured." "White"
Write-Host ""

Write-Host ""
Write-Centered "What we'll install:" "Green"
Write-Centered "* ImpulseRC Driver Fixer   (fixes USB connection issues)" "Gray"
Write-Centered "* Betaflight Configurator  (configure your drone)" "Gray"
Write-Host ""

Write-Centered "Estimated time: 2-3 minutes" "Magenta"
Write-Host ""
Write-Host ""

Write-Centered "=================================================================" "Cyan"
Write-Centered "Starting installation in a moment..." "Cyan"
Write-Centered "=================================================================" "Cyan"
Write-Host ""

Start-Sleep -Seconds 2

# ========================================================
# Step 1: Download and Run ImpulseRC Driver Fixer
# ========================================================
Write-Host "----------------------------------------------------------------" -ForegroundColor Blue
Write-Host " STEP 1/4: Downloading ImpulseRC Driver Fixer                  " -ForegroundColor Blue
Write-Host "----------------------------------------------------------------" -ForegroundColor Blue
Write-Host ""
Write-Host "  >> Downloading from ImpulseRC servers..." -ForegroundColor Cyan

$driverFixerPath = Join-Path $env:TEMP "ImpulseRC_Driver_Fixer.exe"

try {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri "https://impulserc.blob.core.windows.net/utilities/ImpulseRC_Driver_Fixer.exe" -OutFile $driverFixerPath
    Write-Host "  [OK] Download complete!" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host ""
    Write-Host "  [ERROR] Failed to download ImpulseRC Driver Fixer!" -ForegroundColor Red
    Write-Host "  Please check your internet connection and try again." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "----------------------------------------------------------------" -ForegroundColor Blue
Write-Host " STEP 2/4: Running ImpulseRC Driver Fixer                      " -ForegroundColor Blue
Write-Host "----------------------------------------------------------------" -ForegroundColor Blue
Write-Host ""
Write-Host "  >> Launching Driver Fixer application..." -ForegroundColor Cyan
Write-Host "  NOTE: A new window will open. Please follow the instructions." -ForegroundColor Yellow
Write-Host ""

$process = Start-Process -FilePath $driverFixerPath -Wait -PassThru

if ($process.ExitCode -ne 0) {
    Write-Host "  [WARN] Driver Fixer completed with warnings (usually okay)" -ForegroundColor Yellow
} else {
    Write-Host "  [OK] Driver Fixer completed successfully!" -ForegroundColor Green
}
Write-Host ""

# ========================================================
# Step 3: Download and Install Betaflight Configurator
# ========================================================
Write-Host "----------------------------------------------------------------" -ForegroundColor Blue
Write-Host " STEP 3/4: Downloading Betaflight Configurator v10.10.0        " -ForegroundColor Blue
Write-Host "----------------------------------------------------------------" -ForegroundColor Blue
Write-Host ""
Write-Host "  >> Downloading from GitHub (this may take a minute)..." -ForegroundColor Cyan

$betaflightPath = Join-Path $env:TEMP "betaflight-configurator_10.10.0_win64-installer.exe"

try {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri "https://github.com/betaflight/betaflight-configurator/releases/download/10.10.0/betaflight-configurator_10.10.0_win64-installer.exe" -OutFile $betaflightPath
    Write-Host "  [OK] Download complete!" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host ""
    Write-Host "  [ERROR] Failed to download Betaflight Configurator!" -ForegroundColor Red
    Write-Host "  Please check your internet connection and try again." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "----------------------------------------------------------------" -ForegroundColor Blue
Write-Host " STEP 4/4: Installing Betaflight Configurator                  " -ForegroundColor Blue
Write-Host "----------------------------------------------------------------" -ForegroundColor Blue
Write-Host ""
Write-Host "  >> Installing silently in the background..." -ForegroundColor Cyan
Write-Host ""

$process = Start-Process -FilePath $betaflightPath -ArgumentList "/SILENT" -Wait -PassThru

if ($process.ExitCode -ne 0) {
    Write-Host "  [WARN] Installation completed with warnings" -ForegroundColor Yellow
} else {
    Write-Host "  [OK] Betaflight Configurator installed successfully!" -ForegroundColor Green
}
Write-Host ""

# ========================================================
# Cleanup
# ========================================================
Write-Host "  >> Cleaning up temporary files..." -ForegroundColor Cyan
Remove-Item -Path $driverFixerPath -Force -ErrorAction SilentlyContinue
Remove-Item -Path $betaflightPath -Force -ErrorAction SilentlyContinue
Write-Host "  [OK] Cleanup complete!" -ForegroundColor Green
Write-Host ""

# Success banner
Write-Host ""
Write-Centered "=================================================================" "Green"
Write-Centered "                                                                 " "Green"
Write-Centered "              *** INSTALLATION COMPLETE! ***                     " "Green"
Write-Centered "                                                                 " "Green"
Write-Centered "=================================================================" "Green"
Write-Host ""

Write-Host "  All components installed successfully!" -ForegroundColor White
Write-Host ""
Write-Host "  Next steps:" -ForegroundColor Cyan
Write-Host "     1. Connect your drone via USB" -ForegroundColor White
Write-Host "     2. Launch Betaflight Configurator from your Start menu" -ForegroundColor White
Write-Host "     3. Click 'Connect' and start configuring!" -ForegroundColor White
Write-Host ""
Write-Host "  Need help? Ask your instructor or check the documentation!" -ForegroundColor Magenta
Write-Host ""

Write-Host "  Press any key to close this window..." -ForegroundColor Gray
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

