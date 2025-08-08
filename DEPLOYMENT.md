# Deployment Guide for Arabic Keyboard

## Quick Deploy (After Making Changes)

1. **Test your changes locally first**
   ```bash
   # Build and run on simulator/device from Xcode
   ```

2. **Run pre-deployment check**
   ```bash
   ./pre-deploy-check.sh
   ```

3. **Deploy to TestFlight**
   ```bash
   ./deploy.sh
   ```

## What the scripts do:

### `pre-deploy-check.sh`
- Verifies all required files exist
- Checks Info.plist configuration
- Validates Swift syntax
- Ensures network permissions are set

### `deploy.sh`
- Cleans previous builds
- Archives the app
- Fixes any missing executables
- Exports for App Store
- Uploads to TestFlight automatically

## First-time setup (already done):

✅ ExportOptions.plist - Configured for App Store distribution
✅ UploadOptions.plist - Configured for TestFlight upload
✅ ITSAppUsesNonExemptEncryption - Set to false (no encryption compliance needed)
✅ NSAppTransportSecurity - Configured for API calls

## After deployment:

1. Wait 10-30 minutes for Apple to process
2. Check email for "Ready to Test" notification
3. Open TestFlight app on iPhone to install

## Troubleshooting:

### If deployment fails:
- Run `./pre-deploy-check.sh` to identify issues
- Check Xcode is signed in (Xcode → Settings → Accounts)
- Ensure provisioning profiles are up to date

### If upload succeeds but no email:
- Check App Store Connect → My Apps → Your App → TestFlight
- Look for any compliance or review issues

## Version Management:

Before deploying a new version:
1. Update version in Xcode (Project → General → Version/Build)
2. Or edit `KeyboardHost/Info.plist` directly:
   - CFBundleShortVersionString (e.g., "1.0.1")
   - CFBundleVersion (e.g., "2")

## Common Issues Fixed:

- ✅ Missing host app executable → Script copies it automatically
- ✅ Export compliance → ITSAppUsesNonExemptEncryption set to false
- ✅ Network permissions → NSAppTransportSecurity configured
- ✅ API calls in TestFlight → RequestsOpenAccess enabled