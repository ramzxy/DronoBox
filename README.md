# DronoBox

A one-click installer for essential drone development tools on Windows.

## 🚀 Quick Install

Copy and paste this command into **Command Prompt** (run as Administrator):

```cmd
powershell -Command "iwr -Uri 'https://raw.githubusercontent.com/USERNAME/DronoBox/main/installers/install.bat' -OutFile install.bat; .\install.bat"
```

> **Note:** Replace `USERNAME` with the actual GitHub username before using.

## 📦 What Gets Installed

This installer automatically sets up:

1. **ImpulseRC Driver Fixer** - Fixes USB driver issues for flight controllers
2. **Betaflight Configurator** - Configure and tune your drone's flight controller

## 🛠️ Manual Installation

If you prefer to run the installer manually:

1. Download the installer:

   ```cmd
   curl -o install.bat https://raw.githubusercontent.com/USERNAME/DronoBox/main/installers/install.bat
   ```

2. Run it:
   ```cmd
   install.bat
   ```

## ⚠️ Requirements

- Windows 10 or later
- Administrator privileges (required for driver installation)
- Internet connection

## 📝 What Happens During Installation

1. Downloads ImpulseRC Driver Fixer
2. Runs Driver Fixer (requires user interaction)
3. Downloads Betaflight Configurator
4. Installs Betaflight Configurator silently
5. Cleans up temporary files

## 🔒 Security

All downloads come directly from official sources:

- ImpulseRC Driver Fixer: `https://downloads.impulserc.com/`
- Betaflight Configurator: `https://github.com/betaflight/betaflight-configurator/`

## 🐛 Troubleshooting

**"Access Denied" Error**

- Make sure you're running Command Prompt as Administrator
- Right-click Command Prompt → "Run as Administrator"

**Download Fails**

- Check your internet connection
- Verify the URLs are accessible
- Try disabling antivirus temporarily

**Driver Fixer Doesn't Open**

- Some antivirus software may block it
- Download and run manually from [ImpulseRC](https://impulserc.com/pages/downloads)
