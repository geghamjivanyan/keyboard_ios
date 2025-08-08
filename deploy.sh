#!/bin/bash

# Deploy script for ArabicKeyboard
# Usage: ./deploy.sh

echo "🚀 Starting deployment process..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="ArabicKeyboard.xcodeproj"
SCHEME="KeyboardHost"
ARCHIVE_PATH="build/ArabicKeyboard.xcarchive"
EXPORT_PATH="build/Export"
UPLOAD_EXPORT_PATH="build/Upload"

# Step 1: Clean previous builds
echo -e "${YELLOW}Step 1: Cleaning previous builds...${NC}"
rm -rf build/
xcodebuild clean -project $PROJECT_NAME -scheme $SCHEME -configuration Release

# Step 2: Build and Archive
echo -e "${YELLOW}Step 2: Building and archiving...${NC}"
xcodebuild archive \
    -project $PROJECT_NAME \
    -scheme $SCHEME \
    -configuration Release \
    -archivePath $ARCHIVE_PATH \
    -destination "generic/platform=iOS" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=NO

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Archive failed${NC}"
    exit 1
fi

# Step 3: Fix missing executable if needed
echo -e "${YELLOW}Step 3: Checking for host app executable...${NC}"
if [ ! -f "$ARCHIVE_PATH/Products/Applications/KeyboardHost.app/KeyboardHost" ]; then
    echo "Copying missing executable..."
    DERIVED_DATA=$(xcodebuild -project $PROJECT_NAME -showBuildSettings | grep BUILD_DIR | head -1 | awk '{print $3}' | sed 's|/Build/Products||')
    if [ -f "$DERIVED_DATA/Build/Products/Release-iphoneos/KeyboardHost.app/KeyboardHost" ]; then
        cp -R "$DERIVED_DATA/Build/Products/Release-iphoneos/KeyboardHost.app/"* "$ARCHIVE_PATH/Products/Applications/KeyboardHost.app/"
        echo -e "${GREEN}✓ Executable copied${NC}"
    fi
fi

# Step 4: Export for App Store
echo -e "${YELLOW}Step 4: Exporting for App Store...${NC}"
xcodebuild -exportArchive \
    -archivePath $ARCHIVE_PATH \
    -exportOptionsPlist ExportOptions.plist \
    -exportPath $EXPORT_PATH \
    -allowProvisioningUpdates

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Export failed${NC}"
    exit 1
fi

# Step 5: Upload to TestFlight
echo -e "${YELLOW}Step 5: Uploading to TestFlight...${NC}"
xcodebuild -exportArchive \
    -archivePath $ARCHIVE_PATH \
    -exportOptionsPlist UploadOptions.plist \
    -exportPath $UPLOAD_EXPORT_PATH \
    -allowProvisioningUpdates

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Upload failed${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Deployment successful!${NC}"
echo -e "${GREEN}Check your email for TestFlight processing status.${NC}"
echo -e "${YELLOW}Note: Processing usually takes 10-30 minutes${NC}"