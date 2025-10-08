# DronoBox

A one-click installer for essential drone development tools. Supports Windows, macOS, and Linux.

## 🚀 Quick Install

### Windows

Copy and paste this command into **PowerShell** (run as Administrator):

```powershell
iwr -useb https://raw.githubusercontent.com/ramzxy/DronoBox/main/installers/install.ps1 | iex
```

Or if you prefer a longer but more explicit version:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ramzxy/DronoBox/main/installers/install.ps1" -UseBasicParsing | Invoke-Expression
```

From Command Prompt (run as Administrator):

```cmd
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/ramzxy/DronoBox/main/installers/install.ps1 | iex"
```

> **Note**: A traditional `install.bat` batch file is also available in the `installers/` folder if you prefer to download and run it manually.

### macOS

Copy and paste this command into **Terminal**:

```bash
curl -fsSL https://raw.githubusercontent.com/ramzxy/DronoBox/main/installers/install.sh | bash
```

Or download and run manually:

```bash
curl -o install.sh https://raw.githubusercontent.com/ramzxy/DronoBox/main/installers/install.sh
chmod +x install.sh
./install.sh
```

### Linux

Copy and paste this command into **Terminal**:

```bash
curl -fsSL https://raw.githubusercontent.com/ramzxy/DronoBox/main/installers/install-linux.sh | bash
```

Or download and run manually:

```bash
curl -o install-linux.sh https://raw.githubusercontent.com/ramzxy/DronoBox/main/installers/install-linux.sh
chmod +x install-linux.sh
./install-linux.sh
```

## 📦 What Gets Installed

### Windows

1. **ImpulseRC Driver Fixer** - Fixes USB driver issues for flight controllers
2. **Betaflight Configurator** - Configure and tune your drone's flight controller

### macOS

1. **Betaflight Configurator** - Configure and tune your drone's flight controller
   - macOS handles USB drivers automatically

### Linux

1. **Betaflight Configurator** - Configure and tune your drone's flight controller
2. **USB udev rules** - Automatic USB permissions for flight controllers

## ⚠️ Requirements

### Windows

- Windows 10 or later
- Administrator privileges (required for driver installation)
- Internet connection

### macOS

- macOS 10.13 (High Sierra) or later
- Internet connection

### Linux

- Modern Linux distribution (Ubuntu, Fedora, Debian, etc.)
- sudo privileges (for package installation)
- Internet connection

## 📝 What Happens During Installation

### Windows

1. Downloads ImpulseRC Driver Fixer
2. Runs Driver Fixer (requires user interaction)
3. Downloads Betaflight Configurator
4. Installs Betaflight Configurator silently
5. Cleans up temporary files

### macOS

1. Fetches latest Betaflight Configurator version
2. Downloads the .dmg installer
3. Mounts and installs to Applications folder
4. Cleans up temporary files

### Linux

1. Detects your package manager (apt/dnf/yum/AppImage)
2. Downloads appropriate package format
3. Installs Betaflight Configurator
4. Sets up USB permissions (udev rules)
5. Cleans up temporary files

## 🔒 Security

All downloads come directly from official sources:

- ImpulseRC Driver Fixer: `https://downloads.impulserc.com/`
- Betaflight Configurator: `https://github.com/betaflight/betaflight-configurator/`

## 🐛 Troubleshooting

### Windows

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

### macOS

**"App can't be opened" Error**

- Go to System Preferences → Security & Privacy
- Click "Open Anyway" for Betaflight Configurator
- This is normal for apps downloaded from outside the App Store

**Permission Denied**

- Make sure the script is executable: `chmod +x install.sh`

### Linux

**USB Device Not Detected**

- Log out and back in after installation (for group permissions)
- Or run: `sudo udevadm control --reload-rules && sudo udevadm trigger`

**Permission Denied**

- Run the script with sudo if needed for package installation
- Add yourself to plugdev group: `sudo usermod -a -G plugdev $USER`

**AppImage Won't Run**

- Make sure it's executable: `chmod +x ~/.local/bin/betaflight-configurator`
- Ensure `~/.local/bin` is in your PATH
