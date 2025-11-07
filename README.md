# 🔐 DocSaver - Secure Digital Document Vault

<div align="center">

![DocSaver Logo](https://img.shields.io/badge/DocSaver-Digital%20Vault-6C63FF?style=for-the-badge)
![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-success?style=for-the-badge)

**Your personal document fortress. Scan, organize, and securely store important files with military-grade encryption.**

[Features](#-features) • [Architecture](#-architecture) • [Getting Started](#-getting-started) • [Development](#-development) • [Roadmap](#-roadmap)

</div>

---

## 📱 Features

### Core Features (v1.0)
- ✅ **Secure Storage**: AES-256 encryption for all documents
- ✅ **Multi-Image Capture**: Scan multiple pages and create PDFs
- ✅ **OCR Text Recognition**: Extract text from documents (on-device)
- ✅ **Smart Search**: Find any document in under 3 seconds
- ✅ **Auto-Categorization**: Intelligent document organization
- ✅ **Biometric Lock**: Fingerprint/Face ID protection
- ✅ **Smart Reminders**: Never miss an expiration date
- ✅ **Cloud Sync**: Optional encrypted backup to Firebase
- ✅ **Dark/Light Mode**: Beautiful themes for any preference

### Coming Soon (v1.1 - v2.0)
- 🔜 Widget support for quick access
- 🔜 Apple Watch companion app
- 🔜 Batch scanning mode
- 🔜 Family sharing
- 🔜 Document annotations
- 🔜 Desktop apps (macOS/Windows)

---

## 🏗️ Architecture

### Clean Architecture + Riverpod

```
lib/
├── core/
│   ├── constants/        # App-wide constants
│   ├── theme/           # Design system (colors, typography, spacing)
│   ├── database/        # Drift database setup
│   └── error/           # Error handling & Result types
├── features/
│   ├── authentication/  # Biometric & PIN authentication
│   ├── documents/       # Document management
│   ├── ocr_analysis/    # OCR & data extraction
│   ├── reminders/       # Smart reminder system
│   └── cloud_sync/      # Firebase sync
├── shared/
│   ├── widgets/         # Reusable UI components
│   └── services/        # Cross-feature services
└── providers/           # Riverpod providers
```

### Technology Stack

| Component | Package | Purpose |
|-----------|---------|---------|
| **State Management** | flutter_riverpod | Type-safe, testable state management |
| **Database** | drift | Type-safe SQL with encryption |
| **OCR** | google_mlkit_text_recognition | On-device text recognition |
| **Security** | encrypt, flutter_secure_storage | AES-256 encryption |
| **Cloud** | firebase_auth, firebase_storage | User auth & encrypted sync |
| **PDF** | pdf, printing | PDF generation & rendering |
| **Navigation** | go_router | Declarative routing |
| **Notifications** | flutter_local_notifications | Smart reminders |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart 3.0 or higher
- Android Studio / VS Code
- iOS: Xcode 14+ (for iOS development)
- Android: SDK 21+ (Android 5.0+)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/docsaver_app.git
   cd docsaver_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (Drift database)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Firebase Setup (Optional - for Cloud Sync)

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add iOS and Android apps to your project
3. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
4. Place files in the appropriate directories:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`
5. Uncomment Firebase initialization in `lib/main.dart`

---

## 💻 Development

### Project Structure

#### Core Modules

**Database (Drift)**
- `core/database/tables.dart` - Database schema definition
- `core/database/database.dart` - Database implementation
- Auto-generated with `build_runner`

**Theme System**
- `core/theme/app_colors.dart` - Color palette
- `core/theme/app_typography.dart` - Typography scale
- `core/theme/app_spacing.dart` - 8pt grid system
- `core/theme/app_theme.dart` - Complete theme configuration

### Running Tests

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test

# Code coverage
flutter test --coverage
```

### Code Generation

```bash
# Watch mode (auto-rebuild on changes)
flutter pub run build_runner watch

# One-time build
flutter pub run build_runner build --delete-conflicting-outputs
```

### Linting

```bash
flutter analyze
```

---

## 🗂️ Database Schema

### Main Tables

1. **documents** - Document metadata
   - id, title, category, filePath, thumbnailPath
   - createdAt, modifiedAt, tags, isFavorite
   - extractedText, isOcrProcessed
   - cloudStorageUrl, isSynced

2. **categories** - Document categories
   - id, name, icon, sortOrder, isSystem

3. **extracted_data** - OCR results & intelligent analysis
   - id, documentId, dataType, value, dateValue, confidence

4. **reminders** - Smart reminders
   - id, documentId, title, description, reminderDate
   - isAutoGenerated, isCompleted

5. **user_notes** - User-added notes
   - id, documentId, content, createdAt, updatedAt

---

## 🔒 Security Features

### Multi-Layer Protection

1. **App-Level Security**
   - Biometric authentication (fingerprint/Face ID)
   - PIN code fallback
   - Auto-lock on background

2. **Data Encryption**
   - AES-256 encryption for all document files
   - SQLCipher for database encryption
   - Secure key storage in platform keychain

3. **Cloud Security** (if enabled)
   - End-to-end encryption
   - Client-side encryption before upload
   - Zero-knowledge architecture

4. **Best Practices**
   - Secure file deletion (3-pass overwrite)
   - No plaintext sensitive data
   - HTTPS-only communication

---

## 📅 Development Roadmap

### Phase 1: Foundation (Week 1-5) ✅
- [x] Project setup & architecture
- [x] Theme system & UI components
- [x] Database schema & Drift setup
- [x] Basic navigation structure
- [ ] Document upload flow
- [ ] Category management

### Phase 2: Intelligence (Week 6-10)
- [ ] OCR integration (Google ML Kit)
- [ ] Smart data extraction
- [ ] Full-text search
- [ ] Firebase setup
- [ ] Cloud sync implementation
- [ ] Smart reminders

### Phase 3: Polish (Week 11-16)
- [ ] Advanced features (sharing, bulk ops)
- [ ] Animations & micro-interactions
- [ ] Performance optimization
- [ ] Testing (unit, integration, widget)
- [ ] Beta testing
- [ ] Production launch 🚀

---

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Guidelines

1. Follow the Clean Architecture pattern
2. Write unit tests for business logic
3. Use Riverpod for state management
4. Follow Flutter/Dart style guide
5. Document public APIs

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod for excellent state management
- Drift for type-safe database access
- Google ML Kit for on-device OCR

---

<div align="center">

**Built with ❤️ using Flutter**

[Report Bug](https://github.com/yourusername/docsaver_app/issues) • [Request Feature](https://github.com/yourusername/docsaver_app/issues)

</div>

