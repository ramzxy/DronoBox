#!/bin/bash

# DronoBox Installer for macOS
# This script installs Betaflight Configurator on macOS

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
echo "          DronoBox Installation Script (macOS)"
echo "========================================================"
echo ""
echo "This script will install:"
echo "  [1] Betaflight Configurator"
echo ""
echo "Note: ImpulseRC Driver Fixer is Windows-only."
echo "      macOS handles USB drivers automatically."
echo ""
echo "========================================================"
echo ""
sleep 2

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}[ERROR]${NC} This script is for macOS only!"
    echo "Please use install-linux.sh for Linux systems."
    exit 1
fi

# ========================================================
# Step 1: Get latest release URL
# ========================================================
echo -e "${BLUE}[STEP 1/4]${NC} Fetching latest Betaflight Configurator version..."
echo "--------------------------------------------------------"

LATEST_URL=$(curl -s https://api.github.com/repos/betaflight/betaflight-configurator/releases/latest | \
    grep "browser_download_url.*dmg" | \
    cut -d '"' -f 4)

if [ -z "$LATEST_URL" ]; then
    echo -e "${RED}[ERROR]${NC} Failed to fetch latest release URL!"
    echo "Please check your internet connection or visit:"
    echo "https://github.com/betaflight/betaflight-configurator/releases"
    exit 1
fi

echo -e "${GREEN}[SUCCESS]${NC} Found latest version!"
echo ""

# ========================================================
# Step 2: Download Betaflight Configurator
# ========================================================
echo -e "${BLUE}[STEP 2/4]${NC} Downloading Betaflight Configurator..."
echo "--------------------------------------------------------"

DMG_FILE="betaflight-configurator.dmg"
curl -L -o "$DMG_FILE" "$LATEST_URL"

if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR]${NC} Failed to download Betaflight Configurator!"
    exit 1
fi

echo -e "${GREEN}[SUCCESS]${NC} Downloaded successfully!"
echo ""

# ========================================================
# Step 3: Mount and Install
# ========================================================
echo -e "${BLUE}[STEP 3/4]${NC} Installing Betaflight Configurator..."
echo "--------------------------------------------------------"

# Mount the DMG
hdiutil attach "$DMG_FILE" -nobrowse -quiet

if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR]${NC} Failed to mount DMG file!"
    rm -f "$DMG_FILE"
    exit 1
fi

# Find the mounted volume
VOLUME=$(ls -1 /Volumes/ | grep -i betaflight | head -n 1)

if [ -z "$VOLUME" ]; then
    echo -e "${RED}[ERROR]${NC} Could not find mounted volume!"
    rm -f "$DMG_FILE"
    exit 1
fi

# Copy the app to Applications
APP_NAME=$(ls -1 "/Volumes/$VOLUME/" | grep ".app$" | head -n 1)

if [ -z "$APP_NAME" ]; then
    echo -e "${RED}[ERROR]${NC} Could not find .app in DMG!"
    hdiutil detach "/Volumes/$VOLUME" -quiet
    rm -f "$DMG_FILE"
    exit 1
fi

echo "Copying to /Applications..."
cp -R "/Volumes/$VOLUME/$APP_NAME" /Applications/

if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR]${NC} Failed to copy application!"
    hdiutil detach "/Volumes/$VOLUME" -quiet
    rm -f "$DMG_FILE"
    exit 1
fi

echo -e "${GREEN}[SUCCESS]${NC} Betaflight Configurator installed!"
echo ""

# ========================================================
# Step 4: Cleanup
# ========================================================
echo -e "${BLUE}[STEP 4/4]${NC} Cleaning up..."
echo "--------------------------------------------------------"

# Unmount the DMG
hdiutil detach "/Volumes/$VOLUME" -quiet

# Remove the DMG file
rm -f "$DMG_FILE"

echo -e "${GREEN}[SUCCESS]${NC} Cleanup completed!"
echo ""

# ========================================================
# Installation Complete
# ========================================================
echo "========================================================"
echo "          Installation Complete!"
echo "========================================================"
echo ""
echo "Betaflight Configurator has been installed successfully."
echo "You can find it in your Applications folder."
echo ""
echo -e "${YELLOW}Note:${NC} On first launch, you may need to allow the app in"
echo "      System Preferences > Security & Privacy"
echo ""
echo "--------------------------------------------------------"
echo ""

exit 0
