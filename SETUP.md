# 🚀 DocSaver - Setup & Development Guide

## Table of Contents
- [Environment Setup](#environment-setup)
- [Project Setup](#project-setup)
- [Running the App](#running-the-app)
- [Code Generation](#code-generation)
- [Common Issues](#common-issues)

---

## Environment Setup

### 1. Install Flutter

**Windows:**
1. Download Flutter SDK from [flutter.dev](https://flutter.dev)
2. Extract to `C:\flutter`
3. Add to PATH: `C:\flutter\bin`
4. Run `flutter doctor` to verify installation

**macOS:**
```bash
# Using Homebrew
brew install flutter

# Or download manually from flutter.dev
```

**Linux:**
```bash
# Download and extract Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
```

### 2. Install IDE

**VS Code (Recommended)**
- Install VS Code
- Install Flutter extension
- Install Dart extension

**Android Studio**
- Download from [developer.android.com](https://developer.android.com/studio)
- Install Flutter plugin
- Install Dart plugin

### 3. Setup Mobile SDKs

**Android:**
- Install Android Studio
- Install Android SDK (API 21+)
- Setup Android emulator or connect physical device
- Enable USB debugging on device

**iOS (macOS only):**
- Install Xcode from App Store
- Install Xcode Command Line Tools: `xcode-select --install`
- Open Xcode and accept license
- Setup iOS Simulator or connect physical device

---

## Project Setup

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/docsaver_app.git
cd docsaver_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

This will install all packages listed in `pubspec.yaml`.

### 3. Generate Code

The project uses code generation for:
- **Drift** (database)
- **Riverpod** (state management)

```bash
# Generate once
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on changes)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 4. Create Required Directories

```bash
# Create asset directories (if not exist)
mkdir -p assets/images
mkdir -p assets/icons
mkdir -p assets/animations
```

---

## Running the App

### 1. Check Available Devices

```bash
flutter devices
```

### 2. Run on Device/Emulator

```bash
# Run on default device
flutter run

# Run on specific device
flutter run -d <device-id>

# Run in release mode
flutter run --release
```

### 3. Hot Reload

While app is running:
- Press `r` for hot reload
- Press `R` for hot restart
- Press `q` to quit

---

## Code Generation

### Drift Database

When you modify database schema in `lib/core/database/tables.dart`:

1. Save the file
2. Run code generation:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
3. This generates `database.g.dart`

### Riverpod Providers

When using `@riverpod` annotation:

1. Import annotation: `import 'package:riverpod_annotation/riverpod_annotation.dart';`
2. Add part directive: `part 'filename.g.dart';`
3. Run code generation
4. Generated file will be `filename.g.dart`

---

## Project Structure

```
docsaver_app/
├── lib/
│   ├── core/              # Core functionality
│   │   ├── constants/     # App constants
│   │   ├── theme/         # Theme & styling
│   │   ├── database/      # Drift database
│   │   └── error/         # Error handling
│   ├── features/          # Feature modules
│   │   ├── home/
│   │   ├── documents/
│   │   ├── ocr_analysis/
│   │   └── reminders/
│   ├── providers/         # Riverpod providers
│   └── main.dart         # App entry point
├── test/                 # Unit tests
├── integration_test/     # Integration tests
├── assets/              # Images, icons, fonts
├── android/             # Android native code
├── ios/                 # iOS native code
└── pubspec.yaml         # Dependencies
```

---

## Common Issues

### Issue 1: Build Runner Conflicts

**Error:** `Conflicting outputs were detected...`

**Solution:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue 2: Missing Generated Files

**Error:** `'database.g.dart' not found`

**Solution:**
1. Ensure `build_runner` and `drift_dev` are in `dev_dependencies`
2. Run: `flutter pub get`
3. Run: `flutter pub run build_runner build --delete-conflicting-outputs`

### Issue 3: Flutter Doctor Issues

**Error:** Various warnings from `flutter doctor`

**Solution:**
```bash
# Android licenses
flutter doctor --android-licenses

# Accept all licenses
# Type 'y' for all prompts
```

### Issue 4: Gradle Build Failed (Android)

**Error:** Gradle build errors

**Solution:**
1. Clean build:
   ```bash
   cd android
   ./gradlew clean
   cd ..
   flutter clean
   flutter pub get
   ```

### Issue 5: Pod Install Failed (iOS)

**Error:** CocoaPods errors

**Solution:**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
```

### Issue 6: SQLite3 Not Found

**Error:** `sqlite3.dll` not found (Windows)

**Solution:**
The `sqlite3_flutter_libs` package should handle this automatically. If issues persist:
1. Ensure package is in dependencies
2. Run `flutter pub get`
3. Restart IDE

---

## Development Workflow

### Daily Development

1. **Start watch mode:**
   ```bash
   flutter pub run build_runner watch
   ```

2. **Run app:**
   ```bash
   flutter run
   ```

3. **Make changes:**
   - Edit code
   - Save file
   - Hot reload (press `r`)

4. **Test changes:**
   ```bash
   flutter test
   ```

### Before Committing

1. **Format code:**
   ```bash
   flutter format lib/
   ```

2. **Analyze code:**
   ```bash
   flutter analyze
   ```

3. **Run tests:**
   ```bash
   flutter test
   ```

4. **Check coverage:**
   ```bash
   flutter test --coverage
   ```

---

## Firebase Setup (Optional)

### 1. Create Firebase Project

1. Go to [console.firebase.google.com](https://console.firebase.google.com)
2. Create new project
3. Add Android and iOS apps

### 2. Download Config Files

**Android:**
- Download `google-services.json`
- Place in: `android/app/google-services.json`

**iOS:**
- Download `GoogleService-Info.plist`
- Place in: `ios/Runner/GoogleService-Info.plist`

### 3. Update Code

In `lib/main.dart`, uncomment:
```dart
await Firebase.initializeApp();
```

### 4. Enable Services

In Firebase Console:
- Enable Authentication (Email/Password)
- Enable Cloud Storage
- Enable Crashlytics (optional)
- Enable Analytics (optional)

---

## Build for Release

### Android (APK)

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android (App Bundle)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS

```bash
flutter build ios --release
```

Then open `ios/Runner.xcworkspace` in Xcode and archive.

---

## Need Help?

- 📖 [Flutter Documentation](https://flutter.dev/docs)
- 💬 [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- 🐛 [Report Issues](https://github.com/yourusername/docsaver_app/issues)
- 📧 Email: support@docsaver.app

---

**Happy Coding! 🚀**

