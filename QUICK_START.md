# 🚀 Quick Start Guide - DocSaver

## ⚡ TL;DR (Too Long; Didn't Read)

```bash
# 1. Install dependencies
flutter pub get

# 2. Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Run the app
flutter run
```

---

## 📦 What You Have

A fully structured Flutter app with:
- ✅ Clean Architecture setup
- ✅ Riverpod state management
- ✅ Drift database with encryption
- ✅ Beautiful dark/light themes
- ✅ Basic home screen UI
- ✅ Complete documentation

---

## 🛠️ First Time Setup

### Step 1: Install Flutter Packages

Open terminal in project folder and run:

```bash
flutter pub get
```

**Expected Result:** All packages downloaded successfully

### Step 2: Generate Database Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Expected Result:** File `lib/core/database/database.g.dart` is created

### Step 3: Run the App

```bash
flutter run
```

**Expected Result:** App launches on your device/emulator

---

## 📁 Key Files to Know

### Main Entry Point
- `lib/main.dart` - App starts here

### Core Files
- `lib/core/database/database.dart` - Database setup
- `lib/core/theme/app_theme.dart` - App themes
- `lib/core/constants/app_constants.dart` - App constants

### Features
- `lib/features/home/presentation/screens/home_screen.dart` - Home screen

### Providers
- `lib/providers/database_providers.dart` - Database providers

### Documentation
- `README.md` - Project overview
- `SETUP.md` - Detailed setup guide
- `API_DOCS.md` - Code documentation
- `DEV_TASKS.md` - What to build next
- `ROADMAP.md` - Feature roadmap
- `PROJECT_SUMMARY.md` - Complete summary

---

## 🐛 Common Issues & Fixes

### Issue: "Target of URI doesn't exist"
**Fix:** Run `flutter pub get`

### Issue: "database.g.dart not found"
**Fix:** Run `flutter pub run build_runner build --delete-conflicting-outputs`

### Issue: "Gradle build failed" (Android)
**Fix:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Issue: "Pod install failed" (iOS/Mac)
**Fix:**
```bash
cd ios
pod install
cd ..
```

---

## 🎯 What to Build Next

See `DEV_TASKS.md` for complete list. Quick priorities:

1. **Document Upload** - Add camera/file picker
2. **Document List** - Show uploaded documents
3. **Categories** - View and manage categories
4. **Search** - Search documents
5. **OCR** - Extract text from images

---

## 💻 Development Commands

```bash
# Run app
flutter run

# Hot reload (while app is running)
# Press 'r' in terminal

# Run tests
flutter test

# Format code
flutter format lib/

# Check for errors
flutter analyze

# Generate code (watch mode - auto-regenerate)
flutter pub run build_runner watch
```

---

## 📚 Learning Path

### Day 1: Understand Structure
- Read `PROJECT_SUMMARY.md`
- Explore `lib/core/` folder
- Check `lib/features/home/`

### Day 2: Database
- Study `lib/core/database/database.dart`
- Read Drift documentation
- Try adding a test document

### Day 3: UI
- Explore `lib/features/home/presentation/screens/`
- Check theme files in `lib/core/theme/`
- Modify colors and see changes

### Day 4: State Management
- Read `lib/providers/database_providers.dart`
- Learn Riverpod basics
- Create a new provider

### Day 5: Build Features
- Start with document upload
- Follow `DEV_TASKS.md`
- Implement one feature at a time

---

## 🎨 Project Structure at a Glance

```
lib/
├── main.dart                   ← App starts here
├── core/
│   ├── constants/              ← App constants
│   ├── database/               ← Drift database ⚡
│   ├── error/                  ← Error handling
│   ├── theme/                  ← Colors, typography
│   └── utils/                  ← Helper functions
├── features/
│   ├── home/                   ← Home screen
│   ├── documents/              ← Document feature
│   └── [more features...]
├── providers/                  ← Riverpod providers
└── shared/
    └── widgets/                ← Reusable widgets
```

---

## 🔑 Key Concepts

### Clean Architecture
- **Domain** = Business logic (entities, use cases)
- **Data** = Data sources (database, API)
- **Presentation** = UI (screens, widgets)

### Riverpod
- State management solution
- Providers give access to data
- Widgets watch providers for changes

### Drift
- Type-safe SQLite database
- Auto-generates code
- Supports encryption

---

## 🚦 Getting Help

### Quick Reference
- Check `API_DOCS.md` for code examples
- Check `DEV_TASKS.md` for what to build
- Check `SETUP.md` for detailed setup

### External Resources
- [Flutter Docs](https://flutter.dev/docs)
- [Riverpod Docs](https://riverpod.dev)
- [Drift Docs](https://drift.simonbinder.eu)

### Stuck?
1. Check error message
2. Run `flutter doctor`
3. Search error on Google
4. Check GitHub issues

---

## ✅ Checklist: Is Everything Working?

- [ ] Flutter installed (`flutter --version`)
- [ ] Packages installed (`flutter pub get`)
- [ ] Code generated (`database.g.dart` exists)
- [ ] App runs (`flutter run`)
- [ ] No errors (`flutter analyze`)

If all checked, you're ready to build! 🎉

---

## 🎯 Your First Task

Try this simple task to get started:

1. Open `lib/core/theme/app_colors.dart`
2. Change `accent` color to any color you like
3. Save file
4. Run `flutter run`
5. Press 'r' for hot reload
6. See your color change!

**Congratulations!** You just made your first change! 🎊

---

## 🚀 Next Steps

1. Read `PROJECT_SUMMARY.md` for full overview
2. Check `DEV_TASKS.md` for tasks
3. Start building features!

**Happy Coding!** 💻✨

---

**Created:** November 7, 2025  
**Version:** 1.0  
**For:** DocSaver App

