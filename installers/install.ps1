# DronoBox Installation Script for Windows
# Run this with: iwr -useb https://raw.githubusercontent.com/ramzxy/DronoBox/main/installers/install.ps1 | iex

$ErrorActionPreference = "Stop"
$host.ui.RawUI.WindowTitle = "DronoBox Installer - Setting up your drone tools!"

Clear-Host

# Welcome banner with ASCII art
Write-Host ""
Write-Host "    ██████████                                          ███████████                     " -ForegroundColor Cyan
Write-Host "   ▒▒███▒▒▒▒███                                        ▒▒███▒▒▒▒▒███                    " -ForegroundColor Cyan
Write-Host "    ▒███   ▒▒███ ████████   ██████  ████████    ██████  ▒███    ▒███  ██████  █████ █████" -ForegroundColor Cyan
Write-Host "    ▒███    ▒███▒▒███▒▒███ ███▒▒███▒▒███▒▒███  ███▒▒███ ▒██████████  ███▒▒███▒▒███ ▒▒███ " -ForegroundColor Cyan
Write-Host "    ▒███    ▒███ ▒███ ▒▒▒ ▒███ ▒███ ▒███ ▒███ ▒███ ▒███ ▒███▒▒▒▒▒███▒███ ▒███ ▒▒▒█████▒  " -ForegroundColor Cyan
Write-Host "    ▒███    ███  ▒███     ▒███ ▒███ ▒███ ▒███ ▒███ ▒███ ▒███    ▒███▒███ ▒███  ███▒▒▒███ " -ForegroundColor Cyan
Write-Host "    ██████████   █████    ▒▒██████  ████ █████▒▒██████  ███████████ ▒▒██████  █████ █████" -ForegroundColor Cyan
Write-Host "   ▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒      ▒▒▒▒▒▒  ▒▒▒▒ ▒▒▒▒▒  ▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒  ▒▒▒▒▒ ▒▒▒▒▒ " -ForegroundColor Cyan
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║                          🚁  INSTALLATION WIZARD  🚁                                ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
Write-Host ""

Write-Host "  Welcome! This installer will set up everything you need" -ForegroundColor White
Write-Host "  to get your drone connected and configured." -ForegroundColor White
Write-Host ""

Write-Host "  📦 What we'll install:" -ForegroundColor Green
Write-Host "     ✓ ImpulseRC Driver Fixer  " -ForegroundColor Gray -NoNewline
Write-Host "(fixes USB connection issues)" -ForegroundColor DarkGray
Write-Host "     ✓ Betaflight Configurator " -ForegroundColor Gray -NoNewline
Write-Host "(configure your drone)" -ForegroundColor DarkGray
Write-Host ""

Write-Host "  ⏱️  Estimated time: 2-3 minutes" -ForegroundColor Magenta
Write-Host ""

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  Starting installation in a moment...                          ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Start-Sleep -Seconds 2

# ========================================================
# Step 1: Download and Run ImpulseRC Driver Fixer
# ========================================================
Write-Host "┌────────────────────────────────────────────────────────────────┐" -ForegroundColor Blue
Write-Host "│ STEP 1/4: Downloading ImpulseRC Driver Fixer                  │" -ForegroundColor Blue
Write-Host "└────────────────────────────────────────────────────────────────┘" -ForegroundColor Blue
Write-Host ""
Write-Host "  📥 Downloading from ImpulseRC servers..." -ForegroundColor Cyan

$driverFixerPath = Join-Path $env:TEMP "ImpulseRC_Driver_Fixer.exe"

try {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri "https://impulserc.blob.core.windows.net/utilities/ImpulseRC_Driver_Fixer.exe" -OutFile $driverFixerPath
    Write-Host "  ✅ Download complete!" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host ""
    Write-Host "  ❌ ERROR: Failed to download ImpulseRC Driver Fixer!" -ForegroundColor Red
    Write-Host "  Please check your internet connection and try again." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "┌────────────────────────────────────────────────────────────────┐" -ForegroundColor Blue
Write-Host "│ STEP 2/4: Running ImpulseRC Driver Fixer                      │" -ForegroundColor Blue
Write-Host "└────────────────────────────────────────────────────────────────┘" -ForegroundColor Blue
Write-Host ""
Write-Host "  🔧 Launching Driver Fixer application..." -ForegroundColor Cyan
Write-Host "  ℹ️  A new window will open. Please follow the on-screen instructions." -ForegroundColor Yellow
Write-Host ""

$process = Start-Process -FilePath $driverFixerPath -Wait -PassThru

if ($process.ExitCode -ne 0) {
    Write-Host "  ⚠️  Driver Fixer completed with warnings (this is usually okay)" -ForegroundColor Yellow
} else {
    Write-Host "  ✅ Driver Fixer completed successfully!" -ForegroundColor Green
}
Write-Host ""

# ========================================================
# Step 3: Download and Install Betaflight Configurator
# ========================================================
Write-Host "┌────────────────────────────────────────────────────────────────┐" -ForegroundColor Blue
Write-Host "│ STEP 3/4: Downloading Betaflight Configurator v10.10.0        │" -ForegroundColor Blue
Write-Host "└────────────────────────────────────────────────────────────────┘" -ForegroundColor Blue
Write-Host ""
Write-Host "  📥 Downloading from GitHub (this may take a minute)..." -ForegroundColor Cyan

$betaflightPath = Join-Path $env:TEMP "betaflight-configurator_10.10.0_win64-installer.exe"

try {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri "https://github.com/betaflight/betaflight-configurator/releases/download/10.10.0/betaflight-configurator_10.10.0_win64-installer.exe" -OutFile $betaflightPath
    Write-Host "  ✅ Download complete!" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host ""
    Write-Host "  ❌ ERROR: Failed to download Betaflight Configurator!" -ForegroundColor Red
    Write-Host "  Please check your internet connection and try again." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "┌────────────────────────────────────────────────────────────────┐" -ForegroundColor Blue
Write-Host "│ STEP 4/4: Installing Betaflight Configurator                  │" -ForegroundColor Blue
Write-Host "└────────────────────────────────────────────────────────────────┘" -ForegroundColor Blue
Write-Host ""
Write-Host "  ⚙️  Installing silently in the background..." -ForegroundColor Cyan
Write-Host ""

$process = Start-Process -FilePath $betaflightPath -ArgumentList "/SILENT" -Wait -PassThru

if ($process.ExitCode -ne 0) {
    Write-Host "  ⚠️  Installation completed with warnings" -ForegroundColor Yellow
} else {
    Write-Host "  ✅ Betaflight Configurator installed successfully!" -ForegroundColor Green
}
Write-Host ""

# ========================================================
# Cleanup
# ========================================================
Write-Host "  🧹 Cleaning up temporary files..." -ForegroundColor Cyan
Remove-Item -Path $driverFixerPath -Force -ErrorAction SilentlyContinue
Remove-Item -Path $betaflightPath -Force -ErrorAction SilentlyContinue
Write-Host "  ✅ Cleanup complete!" -ForegroundColor Green
Write-Host ""

# Success banner
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                                                                ║" -ForegroundColor Green
Write-Host "║                🎉 INSTALLATION COMPLETE! 🎉                    ║" -ForegroundColor Green
Write-Host "║                                                                ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

Write-Host "  ✨ All components installed successfully!" -ForegroundColor White
Write-Host ""
Write-Host "  🚀 Next steps:" -ForegroundColor Cyan
Write-Host "     1. Connect your drone via USB" -ForegroundColor White
Write-Host "     2. Launch Betaflight Configurator from your Start menu" -ForegroundColor White
Write-Host "     3. Click 'Connect' and start configuring!" -ForegroundColor White
Write-Host ""
Write-Host "  💡 Need help? Ask your instructor or check the documentation!" -ForegroundColor Magenta
Write-Host ""

Write-Host "  Press any key to close this window..." -ForegroundColor Gray
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

