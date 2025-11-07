/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'DocSaver';
  static const String appTagline = 'Your Digital Vault';

  // Database
  static const String databaseName = 'docsaver.db';
  static const String dbEncryptionKeyName = 'db_encryption_key';

  // Secure Storage Keys
  static const String userPinKey = 'user_pin_hash';
  static const String biometricsEnabledKey = 'biometrics_enabled';
  static const String syncEncryptionKeyPrefix = 'file_key_';

  // File Limits
  static const int maxFileSizeMB = 50;
  static const int maxImageWidth = 1920;
  static const int imageQuality = 85;

  // OCR
  static const int ocrRetryAttempts = 3;
  static const Duration ocrTimeout = Duration(seconds: 30);

  // Search
  static const int searchResultsLimit = 100;
  static const Duration searchDebounce = Duration(milliseconds: 500);

  // Sync
  static const Duration syncInterval = Duration(hours: 6);
  static const int maxSyncRetries = 3;

  // Notifications
  static const String notificationChannelId = 'document_reminders';
  static const String notificationChannelName = 'Document Reminders';

  // Default Categories
  static const List<Map<String, dynamic>> defaultCategories = [
    {'name': 'Passports', 'icon': '🛂', 'isSystem': true},
    {'name': 'IDs', 'icon': '🪪', 'isSystem': true},
    {'name': 'Driver Licenses', 'icon': '🚗', 'isSystem': true},
    {'name': 'Contracts', 'icon': '📝', 'isSystem': true},
    {'name': 'Invoices', 'icon': '🧾', 'isSystem': true},
    {'name': 'Receipts', 'icon': '🧾', 'isSystem': true},
    {'name': 'Insurance', 'icon': '🛡️', 'isSystem': true},
    {'name': 'Medical Records', 'icon': '⚕️', 'isSystem': true},
    {'name': 'Certificates', 'icon': '🎓', 'isSystem': true},
    {'name': 'Tax Documents', 'icon': '💰', 'isSystem': true},
    {'name': 'Bank Statements', 'icon': '🏦', 'isSystem': true},
    {'name': 'Other', 'icon': '📄', 'isSystem': true},
  ];
}

