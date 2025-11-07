# دليل إعداد Firebase لتطبيق DocSaver

## نظرة عامة

هذا الدليل يوضح خطوات تكوين Firebase لتطبيق DocSaver على منصة Android. Firebase تم تكوينه بالفعل في الكود، وتحتاج فقط إلى إضافة ملف التكوين.

## الخدمات المفعّلة في التطبيق

التطبيق مُعد للعمل مع الخدمات التالية من Firebase:
- ✅ **Firebase Core** - الأساسيات
- ✅ **Firebase Authentication** - المصادقة والمستخدمين
- ✅ **Firebase Storage** - تخزين الملفات والمستندات
- ✅ **Firebase Analytics** - تحليلات الاستخدام
- ✅ **Firebase Crashlytics** - تتبع الأخطاء

## الخطوات المطلوبة

### 1️⃣ إنشاء مشروع Firebase

1. انتقل إلى [Firebase Console](https://console.firebase.google.com/)
2. انقر على "Add project" أو "إضافة مشروع"
3. أدخل اسم المشروع (مثال: `DocSaver` أو `docsaver-app`)
4. اختر تفعيل Google Analytics (اختياري ولكن موصى به)
5. اختر حساب Analytics أو أنشئ حساب جديد
6. انقر على "Create project"

### 2️⃣ تسجيل تطبيق Android

1. من لوحة تحكم Firebase، انقر على أيقونة Android
2. املأ التفاصيل التالية:
   - **Android package name**: `com.bagomri.docsaver.docsaver_app`
   - **App nickname** (اختياري): `DocSaver Android`
   - **Debug signing certificate SHA-1** (اختياري): يمكن إضافته لاحقاً
3. انقر على "Register app"

### 3️⃣ تحميل ملف google-services.json

1. بعد تسجيل التطبيق، ستظهر لك شاشة لتحميل ملف `google-services.json`
2. انقر على "Download google-services.json"
3. احفظ الملف في المكان التالي بالضبط:
   ```
   android/app/google-services.json
   ```

⚠️ **مهم جداً**: تأكد أن الملف موجود في المسار الصحيح:
```
docsaver-app/
├── android/
│   ├── app/
│   │   ├── google-services.json  ← هنا بالضبط
│   │   ├── build.gradle.kts
│   │   └── src/
│   └── build.gradle.kts
├── lib/
└── pubspec.yaml
```

### 4️⃣ تفعيل الخدمات في Firebase Console

#### Firebase Authentication
1. من القائمة الجانبية، اذهب إلى **Build** > **Authentication**
2. انقر على "Get started"
3. فعّل طرق المصادقة التي تريدها:
   - Email/Password
   - Google Sign-In
   - Anonymous (للاختبار)

#### Firebase Storage
1. من القائمة الجانبية، اذهب إلى **Build** > **Storage**
2. انقر على "Get started"
3. اختر قواعد الأمان:
   - للتطوير: اختر "Start in test mode"
   - للإنتاج: راجع قواعد الأمان وعدّلها حسب حاجتك
4. اختر موقع التخزين (مثال: `us-central1`)

#### Firebase Analytics
- Analytics يتم تفعيله تلقائياً إذا اخترته عند إنشاء المشروع

#### Firebase Crashlytics
1. من القائمة الجانبية، اذهب إلى **Release & Monitor** > **Crashlytics**
2. انقر على "Get started"
3. اتبع التعليمات (معظم الإعداد موجود بالفعل في الكود)

### 5️⃣ التحقق من التثبيت

بعد إضافة ملف `google-services.json`:

1. نظف المشروع وأعد البناء:
   ```bash
   flutter clean
   flutter pub get
   ```

2. شغّل التطبيق:
   ```bash
   flutter run
   ```

3. تحقق من السجلات (Logcat) - يجب أن تختفي رسائل الخطأ التالية:
   ```
   ❌ E/FA: Missing google_app_id. Firebase Analytics disabled.
   ❌ E/FA: Uploading is not possible. App measurement disabled
   ```

4. يجب أن ترى رسائل نجاح Firebase:
   ```
   ✅ I/FirebaseApp: Device unlocked: initializing all Firebase APIs for app [DEFAULT]
   ✅ I/FA: App measurement initialized
   ```

## هيكل ملف google-services.json

الملف يجب أن يحتوي على معلومات مشروعك من Firebase:

```json
{
  "project_info": {
    "project_number": "123456789012",
    "project_id": "your-project-id",
    "storage_bucket": "your-project-id.appspot.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:123456789012:android:abcdef123456",
        "android_client_info": {
          "package_name": "com.bagomri.docsaver.docsaver_app"
        }
      },
      "api_key": [
        {
          "current_key": "YOUR_API_KEY_HERE"
        }
      ]
    }
  ]
}
```

## الحصول على SHA-1 Certificate (للمصادقة)

لتفعيل Google Sign-In أو غيرها من خدمات المصادقة، تحتاج SHA-1:

### للتطوير (Debug):
```bash
cd android
./gradlew signingReport
```

ابحث عن:
```
Variant: debug
Config: debug
Store: ~/.android/debug.keystore
SHA1: XX:XX:XX:XX:...
```

### للإنتاج (Release):
إذا كان لديك keystore للإنتاج:
```bash
keytool -list -v -keystore your-release-key.keystore -alias your-key-alias
```

ثم أضف SHA-1 في Firebase Console:
1. اذهب إلى **Project Settings** > **Your apps**
2. اختر تطبيق Android
3. انزل إلى "SHA certificate fingerprints"
4. انقر على "Add fingerprint"
5. الصق SHA-1

## الملفات المُعدة مسبقاً

التطبيق مُعد بالفعل بالتكوينات التالية:

### ✅ pubspec.yaml
```yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_auth: ^4.17.0
  firebase_storage: ^11.6.0
  firebase_crashlytics: ^3.4.0
  firebase_analytics: ^10.8.0
```

### ✅ android/build.gradle.kts
```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
    }
}
```

### ✅ android/app/build.gradle.kts
```kotlin
plugins {
    id("com.google.gms.google-services")
}
```

### ✅ lib/main.dart
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  } catch (e) {
    debugPrint('Firebase initialization skipped: $e');
  }
  
  runApp(const ProviderScope(child: DocSaverApp()));
}
```

## استكشاف الأخطاء

### المشكلة: "Missing google_app_id"
**الحل**: تأكد من وجود ملف `google-services.json` في `android/app/`

### المشكلة: "Default FirebaseApp is not initialized"
**الحل**: 
1. تأكد من وجود `google-services.json`
2. نفذ `flutter clean && flutter pub get`
3. أعد تشغيل التطبيق

### المشكلة: "Failed to parse google-services.json"
**الحل**:
1. تأكد من صحة بناء JSON في الملف
2. تأكد من أن `package_name` مطابق: `com.bagomri.docsaver.docsaver_app`
3. أعد تحميل الملف من Firebase Console

### المشكلة: Firebase Analytics لا يعمل
**الحل**:
1. تأكد من تفعيل Analytics في Firebase Console
2. انتظر 24 ساعة لظهور أول بيانات
3. تأكد من استخدام جهاز/محاكي حقيقي (ليس release mode في debug)

## الأمان ⚠️

### ملاحظات مهمة:
1. **لا تشارك** ملف `google-services.json` في repositories عامة
2. أضف `google-services.json` إلى `.gitignore` إذا كان المشروع عام
3. استخدم قواعد أمان Firebase Storage لحماية البيانات
4. فعّل App Check لحماية التطبيق من إساءة الاستخدام

### قواعد Storage الآمنة (مثال):
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## الخطوات التالية

بعد إعداد Firebase:
1. ✅ اختبر المصادقة (تسجيل دخول/خروج)
2. ✅ اختبر رفع ملف إلى Storage
3. ✅ راجع Analytics في Firebase Console
4. ✅ اختبر تقارير Crashlytics
5. ✅ راجع قواعد الأمان للإنتاج

## روابط مفيدة

- [Firebase Console](https://console.firebase.google.com/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [Firebase Storage](https://firebase.google.com/docs/storage)
- [Firebase Analytics](https://firebase.google.com/docs/analytics)

## الدعم

إذا واجهت أي مشاكل:
1. راجع قسم "استكشاف الأخطاء" أعلاه
2. تحقق من سجلات التطبيق (Logcat)
3. راجع [FlutterFire Issues](https://github.com/firebase/flutterfire/issues)

---

**آخر تحديث**: 2025-11-07  
**الإصدار**: 1.0
