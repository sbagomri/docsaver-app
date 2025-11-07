# Firebase Setup Guide for DocSaver App

## Overview
This guide will help you complete the Firebase integration for the DocSaver Android app.

## Prerequisites
- Firebase project created at [Firebase Console](https://console.firebase.google.com/)
- Android app registered in your Firebase project with package name: `com.bagomri.docsaver.docsaver_app`

## Setup Steps

### 1. Download google-services.json

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your DocSaver project
3. Click on the gear icon (⚙️) and select **Project settings**
4. Scroll down to **Your apps** section
5. Click on your Android app (or add one if not exists)
   - Package name: `com.bagomri.docsaver.docsaver_app`
   - App nickname: DocSaver (optional)
   - Debug signing certificate SHA-1 (optional, but recommended for Firebase Auth)
6. Click **Download google-services.json**

### 2. Place the File

Place the downloaded `google-services.json` file in:
```
android/app/google-services.json
```

**Important Notes:**
- The file is already in `.gitignore` for security reasons
- Do NOT commit this file to version control
- Each developer/environment should have their own copy

### 3. Verify Configuration

The following configuration has already been added to the Android build files:

#### settings.gradle.kts
```kotlin
plugins {
    // ... other plugins
    id("com.google.gms.google-services") version "4.4.0" apply false
}
```

#### app/build.gradle.kts
```kotlin
plugins {
    // ... other plugins
    id("com.google.gms.google-services")
}
```

### 4. Firebase Services Configuration

The app is configured to use the following Firebase services:

- **Firebase Core** (v2.24.0) - Required base
- **Firebase Auth** (v4.17.0) - Authentication
- **Firebase Storage** (v11.6.0) - File storage
- **Firebase Crashlytics** (v3.4.0) - Crash reporting
- **Firebase Analytics** (v10.8.0) - App analytics

### 5. Enable Firebase Services in Console

Make sure to enable the following services in your Firebase Console:

1. **Authentication**
   - Go to Authentication → Sign-in method
   - Enable desired sign-in providers (Email/Password, Google, etc.)

2. **Storage**
   - Go to Storage → Get started
   - Set up Cloud Storage bucket
   - Configure security rules as needed

3. **Crashlytics**
   - Go to Crashlytics → Enable Crashlytics
   - Follow the setup wizard

4. **Analytics**
   - Usually enabled by default when creating a project
   - Verify in Analytics dashboard

### 6. Generate SHA-1 Certificate (Optional but Recommended)

For Firebase Authentication (especially Google Sign-In), you need to add SHA-1 certificates:

#### Debug Certificate:
```bash
# On Windows:
keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore

# On macOS/Linux:
keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
```

Password: `android`

#### Release Certificate:
If you have a release keystore, get its SHA-1 and add it to Firebase Console as well.

Add both SHA-1 certificates to:
- Firebase Console → Project Settings → Your apps → Android app → Add fingerprint

### 7. iOS Configuration (Future)

When you're ready to support iOS, you'll need to:
1. Register iOS app in Firebase Console
2. Download `GoogleService-Info.plist`
3. Place it in `ios/Runner/` directory
4. Add iOS-specific Firebase configuration

### 8. Test Firebase Integration

After placing the `google-services.json` file:

```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Run the app
flutter run
```

The app should now initialize Firebase successfully. Check the logs for:
```
Firebase initialized successfully
```

If you see Firebase initialization errors, verify:
- ✅ `google-services.json` is in the correct location
- ✅ Package name matches: `com.bagomri.docsaver.docsaver_app`
- ✅ File is valid JSON
- ✅ All required Firebase services are enabled in Console

### 9. Verify Firebase Features

Once Firebase is initialized, you can test:

1. **Authentication**: Try signing up/logging in
2. **Storage**: Upload a test document
3. **Crashlytics**: Force a test crash to verify reporting
4. **Analytics**: Check events in Firebase Console

### 10. Production Considerations

Before releasing to production:

- [ ] Use release keystore and add its SHA-1 to Firebase
- [ ] Configure proper Firebase Storage security rules
- [ ] Set up proper Authentication security rules
- [ ] Review Firebase Console IAM permissions
- [ ] Set up budget alerts for Firebase usage
- [ ] Test all Firebase features thoroughly

## Troubleshooting

### "google-services.json is missing"
- Ensure the file is in `android/app/` directory
- File name must be exactly `google-services.json` (no extra extensions)

### "Default FirebaseApp is not initialized"
- Make sure `google-services.json` is present
- Verify package name matches in file and build.gradle.kts
- Try `flutter clean` and rebuild

### Firebase Auth not working
- Add SHA-1 certificate to Firebase Console
- Enable authentication methods in Firebase Console
- Check internet connectivity

### Build errors related to Firebase
- Ensure Google Services plugin version is compatible
- Check that all Firebase dependencies are compatible versions
- Try `flutter pub upgrade` to update dependencies

## Security Best Practices

1. **Never commit** `google-services.json` to version control
2. **Use different Firebase projects** for development and production
3. **Set up Firebase Security Rules** properly
4. **Enable App Check** to prevent abuse
5. **Monitor Firebase usage** to detect anomalies
6. **Use environment-specific configurations** for different build variants

## Additional Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/)

## Need Help?

If you encounter issues:
1. Check Firebase Console for configuration issues
2. Review Flutter logs for detailed error messages
3. Verify all setup steps were completed
4. Check Firebase status page for service issues
5. Consult FlutterFire documentation for specific features

---

**Note**: The user mentioned they have already uploaded the `google-services.json` file. If you have already done this, ensure it's placed correctly in `android/app/google-services.json` and proceed with testing.
