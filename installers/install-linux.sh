#!/bin/bash

# DronoBox Installer for Linux
# This script installs Betaflight Configurator on Linux

set -e

# Colors for better visuals
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Clear screen and show header
clear
echo ""
echo "========================================================"
echo "          DronoBox Installation Script (Linux)"
echo "========================================================"
echo ""
echo "This script will install:"
echo "  [1] Betaflight Configurator"
echo ""
echo "Note: ImpulseRC Driver Fixer is Windows-only."
echo "      Linux handles USB drivers through udev rules."
echo ""
echo "========================================================"
echo ""
sleep 2

# Check if running on Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo -e "${RED}[ERROR]${NC} This script is for Linux only!"
    echo "Please use install.sh for macOS systems."
    exit 1
fi

# Detect package manager and distribution
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt"
    INSTALLER="apt-get"
    DISTRO="debian"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
    INSTALLER="dnf"
    DISTRO="fedora"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    INSTALLER="yum"
    DISTRO="redhat"
else
    PKG_MANAGER="appimage"
    DISTRO="other"
fi

echo -e "${BLUE}[INFO]${NC} Detected package manager: $PKG_MANAGER"
echo ""

# ========================================================
# Step 1: Determine download URL based on package manager
# ========================================================
echo -e "${BLUE}[STEP 1/4]${NC} Preparing Betaflight Configurator v10.10.0..."
echo "--------------------------------------------------------"

VERSION="10.10.0"
BASE_URL="https://github.com/betaflight/betaflight-configurator/releases/download/${VERSION}"

if [ "$PKG_MANAGER" = "apt" ]; then
    DOWNLOAD_URL="${BASE_URL}/betaflight-configurator_${VERSION}_amd64.deb"
    FILE_EXT="deb"
elif [ "$PKG_MANAGER" = "dnf" ] || [ "$PKG_MANAGER" = "yum" ]; then
    DOWNLOAD_URL="${BASE_URL}/betaflight-configurator-${VERSION}-1.x86_64.rpm"
    FILE_EXT="rpm"
else
    # No AppImage for this version, fall back to DEB (can be converted)
    echo -e "${YELLOW}[WARNING]${NC} No AppImage available for v${VERSION}"
    echo "              Falling back to .deb package (requires alien or manual extraction)"
    DOWNLOAD_URL="${BASE_URL}/betaflight-configurator_${VERSION}_amd64.deb"
    FILE_EXT="deb"
fi

echo -e "${GREEN}[SUCCESS]${NC} Package format: $FILE_EXT"
echo ""

# ========================================================
# Step 2: Download Betaflight Configurator
# ========================================================
echo -e "${BLUE}[STEP 2/4]${NC} Downloading Betaflight Configurator v${VERSION}..."
echo "--------------------------------------------------------"

INSTALLER_FILE="betaflight-configurator.$FILE_EXT"
curl -L -o "$INSTALLER_FILE" "$DOWNLOAD_URL"

if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR]${NC} Failed to download Betaflight Configurator!"
    echo "Please check your internet connection or visit:"
    echo "https://github.com/betaflight/betaflight-configurator/releases"
    exit 1
fi

echo -e "${GREEN}[SUCCESS]${NC} Downloaded successfully!"
echo ""

# ========================================================
# Step 3: Install Betaflight Configurator
# ========================================================
echo -e "${BLUE}[STEP 3/4]${NC} Installing Betaflight Configurator..."
echo "--------------------------------------------------------"

if [ "$FILE_EXT" = "deb" ]; then
    sudo dpkg -i "$INSTALLER_FILE" || sudo apt-get install -f -y
    if [ $? -ne 0 ]; then
        echo -e "${RED}[ERROR]${NC} Installation failed!"
        rm -f "$INSTALLER_FILE"
        exit 1
    fi
elif [ "$FILE_EXT" = "rpm" ]; then
    sudo $INSTALLER install -y "$INSTALLER_FILE"
    if [ $? -ne 0 ]; then
        echo -e "${RED}[ERROR]${NC} Installation failed!"
        rm -f "$INSTALLER_FILE"
        exit 1
    fi
else
    # AppImage - move to user's bin directory
    mkdir -p ~/.local/bin
    mv "$INSTALLER_FILE" ~/.local/bin/betaflight-configurator
    chmod +x ~/.local/bin/betaflight-configurator
    
    # Create desktop entry
    mkdir -p ~/.local/share/applications
    cat > ~/.local/share/applications/betaflight-configurator.desktop << EOF
[Desktop Entry]
Name=Betaflight Configurator
Exec=$HOME/.local/bin/betaflight-configurator
Icon=betaflight
Type=Application
Categories=Development;
Terminal=false
EOF
    
    echo -e "${YELLOW}[NOTE]${NC} AppImage installed to ~/.local/bin/"
    echo "      Make sure ~/.local/bin is in your PATH"
fi

echo -e "${GREEN}[SUCCESS]${NC} Betaflight Configurator installed!"
echo ""

# ========================================================
# Step 4: Cleanup
# ========================================================
echo -e "${BLUE}[STEP 4/4]${NC} Setting up USB permissions and cleaning up..."
echo "--------------------------------------------------------"

UDEV_RULES="/etc/udev/rules.d/99-betaflight.rules"

if [ ! -f "$UDEV_RULES" ]; then
    echo "Creating udev rules for flight controllers..."
    
    sudo tee "$UDEV_RULES" > /dev/null << 'EOF'
# DFU Mode
SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0664", GROUP="plugdev"
# STM32 VCP
SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", MODE="0664", GROUP="plugdev"
# CP210x
SUBSYSTEM=="usb", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE="0664", GROUP="plugdev"
# FT232
SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="0664", GROUP="plugdev"
# CH340
SUBSYSTEM=="usb", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", MODE="0664", GROUP="plugdev"
EOF
    
    # Add user to plugdev group
    sudo usermod -a -G plugdev "$USER"
    
    # Reload udev rules
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    
    echo -e "${GREEN}[SUCCESS]${NC} USB permissions configured!"
    echo -e "${YELLOW}[NOTE]${NC} You may need to log out and back in for group changes to take effect."
else
    echo -e "${YELLOW}[SKIP]${NC} udev rules already exist"
fi

# Cleanup installer file
if [ "$FILE_EXT" != "AppImage" ]; then
    rm -f "$INSTALLER_FILE"
fi

echo -e "${GREEN}[SUCCESS]${NC} Setup completed!"
echo ""

# ========================================================
# Installation Complete
# ========================================================
echo "========================================================"
echo "          Installation Complete!"
echo "========================================================"
echo ""
echo "Betaflight Configurator has been installed successfully."
echo ""
if [ "$FILE_EXT" = "AppImage" ]; then
    echo "To run: betaflight-configurator"
    echo "Or search for 'Betaflight' in your application menu."
else
    echo "You can launch it from your application menu."
fi
echo ""
echo -e "${YELLOW}Important:${NC} If this is your first time using flight"
echo "           controllers, you may need to log out and back in"
echo "           for USB permissions to take effect."
echo ""
echo "--------------------------------------------------------"
echo ""

exit 0
