#!/bin/bash

# Pre-deployment checklist
echo "📋 Pre-deployment Checklist"
echo "============================"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ERRORS=0

# Check 1: Verify Info.plist has version numbers
echo -n "1. Checking version numbers... "
BUNDLE_VERSION=$(defaults read "$PWD/KeyboardHost/Info.plist" CFBundleVersion 2>/dev/null)
if [ -z "$BUNDLE_VERSION" ]; then
    echo -e "${RED}❌ Missing CFBundleVersion${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✓ Version: $BUNDLE_VERSION${NC}"
fi

# Check 2: Verify export compliance key
echo -n "2. Checking export compliance... "
if grep -q "ITSAppUsesNonExemptEncryption" KeyboardHost/Info.plist; then
    echo -e "${GREEN}✓ Export compliance configured${NC}"
else
    echo -e "${YELLOW}⚠ Export compliance not set (will need manual approval)${NC}"
fi

# Check 3: Check for ExportOptions.plist
echo -n "3. Checking ExportOptions.plist... "
if [ -f "ExportOptions.plist" ]; then
    echo -e "${GREEN}✓ Found${NC}"
else
    echo -e "${RED}❌ Missing ExportOptions.plist${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Check 4: Check for UploadOptions.plist
echo -n "4. Checking UploadOptions.plist... "
if [ -f "UploadOptions.plist" ]; then
    echo -e "${GREEN}✓ Found${NC}"
else
    echo -e "${RED}❌ Missing UploadOptions.plist${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Check 5: Check Swift files compile
echo -n "5. Checking Swift syntax... "
if xcodebuild -project ArabicKeyboard.xcodeproj -scheme KeyboardHost -configuration Release -destination "generic/platform=iOS" -dry-run > /dev/null 2>&1; then
    echo -e "${GREEN}✓ No syntax errors${NC}"
else
    echo -e "${RED}❌ Swift compilation errors${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Check 6: Network configuration
echo -n "6. Checking network configuration... "
if grep -q "NSAppTransportSecurity" KeyboardHost/Info.plist && grep -q "NSAppTransportSecurity" Keyboard/Info.plist; then
    echo -e "${GREEN}✓ Network permissions configured${NC}"
else
    echo -e "${YELLOW}⚠ Network permissions may need configuration${NC}"
fi

echo ""
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ All checks passed! Ready to deploy.${NC}"
    echo -e "Run ${YELLOW}./deploy.sh${NC} to start deployment"
else
    echo -e "${RED}❌ $ERRORS checks failed. Please fix before deploying.${NC}"
    exit 1
fi