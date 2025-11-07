#!/bin/bash

# Firebase Configuration Verification Script
# This script checks if Firebase is properly configured for the DocSaver app

echo "=================================="
echo "Firebase Configuration Checker"
echo "=================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}Error: pubspec.yaml not found. Please run this script from the root of the Flutter project.${NC}"
    exit 1
fi

echo "Checking Firebase configuration..."
echo ""

# 1. Check if google-services.json exists
echo -n "1. Checking for google-services.json... "
if [ -f "android/app/google-services.json" ]; then
    echo -e "${GREEN}✓ Found${NC}"
    GOOGLE_SERVICES_EXISTS=true
else
    echo -e "${RED}✗ Not found${NC}"
    echo -e "   ${YELLOW}Please place your google-services.json in android/app/${NC}"
    GOOGLE_SERVICES_EXISTS=false
fi

# 2. Check if template exists
echo -n "2. Checking for template file... "
if [ -f "android/app/google-services.json.template" ]; then
    echo -e "${GREEN}✓ Found${NC}"
else
    echo -e "${YELLOW}⚠ Template not found (not critical)${NC}"
fi

# 3. Check Google Services plugin in settings.gradle.kts
echo -n "3. Checking settings.gradle.kts... "
if grep -q "com.google.gms.google-services" "android/settings.gradle.kts"; then
    echo -e "${GREEN}✓ Plugin declared${NC}"
else
    echo -e "${RED}✗ Plugin not declared${NC}"
fi

# 4. Check Google Services plugin in app/build.gradle.kts
echo -n "4. Checking app/build.gradle.kts... "
if grep -q "com.google.gms.google-services" "android/app/build.gradle.kts"; then
    echo -e "${GREEN}✓ Plugin applied${NC}"
else
    echo -e "${RED}✗ Plugin not applied${NC}"
fi

# 5. Check Firebase dependencies in pubspec.yaml
echo -n "5. Checking Firebase dependencies... "
FIREBASE_DEPS_COUNT=$(grep -c "firebase_" "pubspec.yaml")
if [ $FIREBASE_DEPS_COUNT -ge 5 ]; then
    echo -e "${GREEN}✓ Found $FIREBASE_DEPS_COUNT Firebase dependencies${NC}"
else
    echo -e "${YELLOW}⚠ Only found $FIREBASE_DEPS_COUNT Firebase dependencies${NC}"
fi

# 6. Check Firebase initialization in main.dart
echo -n "6. Checking Firebase initialization... "
if grep -q "Firebase.initializeApp()" "lib/main.dart"; then
    echo -e "${GREEN}✓ Firebase.initializeApp() found${NC}"
else
    echo -e "${RED}✗ Firebase initialization not found${NC}"
fi

# 7. Check MultiDex
echo -n "7. Checking MultiDex... "
if grep -q "multiDexEnabled = true" "android/app/build.gradle.kts"; then
    echo -e "${GREEN}✓ MultiDex enabled${NC}"
else
    echo -e "${YELLOW}⚠ MultiDex not enabled${NC}"
fi

# 8. Check Core Library Desugaring
echo -n "8. Checking Core Library Desugaring... "
if grep -q "isCoreLibraryDesugaringEnabled = true" "android/app/build.gradle.kts"; then
    echo -e "${GREEN}✓ Core Library Desugaring enabled${NC}"
else
    echo -e "${YELLOW}⚠ Core Library Desugaring not enabled${NC}"
fi

echo ""
echo "=================================="

# Validate google-services.json if it exists
if [ "$GOOGLE_SERVICES_EXISTS" = true ]; then
    echo ""
    echo "Validating google-services.json..."
    
    # Check if it's valid JSON
    if command -v jq &> /dev/null; then
        if jq empty "android/app/google-services.json" 2>/dev/null; then
            echo -e "${GREEN}✓ Valid JSON format${NC}"
            
            # Check package name
            PACKAGE_NAME=$(jq -r '.client[0].client_info.android_client_info.package_name' "android/app/google-services.json" 2>/dev/null)
            echo -n "   Package name: "
            if [ "$PACKAGE_NAME" = "com.bagomri.docsaver.docsaver_app" ]; then
                echo -e "${GREEN}$PACKAGE_NAME ✓${NC}"
            else
                echo -e "${RED}$PACKAGE_NAME${NC}"
                echo -e "   ${YELLOW}Expected: com.bagomri.docsaver.docsaver_app${NC}"
            fi
            
            # Check project ID
            PROJECT_ID=$(jq -r '.project_info.project_id' "android/app/google-services.json" 2>/dev/null)
            if [ "$PROJECT_ID" != "null" ] && [ "$PROJECT_ID" != "YOUR_PROJECT_ID" ]; then
                echo -e "   Project ID: ${GREEN}$PROJECT_ID ✓${NC}"
            else
                echo -e "   ${RED}Project ID not set properly${NC}"
            fi
        else
            echo -e "${RED}✗ Invalid JSON format${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ jq not installed, skipping JSON validation${NC}"
        echo "   Install jq to enable JSON validation: https://stedolan.github.io/jq/"
    fi
fi

echo ""
echo "=================================="
echo "Summary"
echo "=================================="

if [ "$GOOGLE_SERVICES_EXISTS" = true ]; then
    echo -e "${GREEN}✓ google-services.json is present${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Run: flutter clean"
    echo "2. Run: flutter pub get"
    echo "3. Run: flutter run"
    echo ""
    echo "Check the logs for: 'Firebase initialized successfully'"
else
    echo -e "${RED}✗ google-services.json is missing${NC}"
    echo ""
    echo "To fix this:"
    echo "1. Download google-services.json from Firebase Console"
    echo "2. Place it in: android/app/google-services.json"
    echo "3. Run this script again to verify"
    echo ""
    echo "See FIREBASE_SETUP.md for detailed instructions"
fi

echo ""
echo "Documentation:"
echo "- FIREBASE_SETUP.md: Complete setup guide"
echo "- FIREBASE_CONFIG_COMPLETE.md: Quick reference"
echo "- FIREBASE_IMPLEMENTATION_SUMMARY.md: Implementation details"
echo ""
