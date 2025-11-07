import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import '../constants/app_constants.dart';
import 'tables.dart';

part 'database.g.dart';

/// Main application database with encryption
@DriftDatabase(tables: [
  Documents,
  ExtractedData,
  Reminders,
  UserNotes,
  Categories,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();

        // Insert default categories
        for (var i = 0; i < AppConstants.defaultCategories.length; i++) {
          final cat = AppConstants.defaultCategories[i];
          await into(categories).insert(
            CategoriesCompanion.insert(
              name: cat['name'] as String,
              icon: cat['icon'] as String,
              sortOrder: i,
              isSystem: Value(cat['isSystem'] as bool),
              createdAt: DateTime.now(),
            ),
          );
        }
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future schema upgrades
      },
    );
  }

  // Helper methods for common queries

  /// Get all documents
  Future<List<Document>> getAllDocuments() => select(documents).get();

  /// Get documents by category
  Future<List<Document>> getDocumentsByCategory(String category) {
    return (select(documents)..where((tbl) => tbl.category.equals(category))).get();
  }

  /// Get favorite documents
  Future<List<Document>> getFavoriteDocuments() {
    return (select(documents)..where((tbl) => tbl.isFavorite.equals(true))).get();
  }

  /// Get recent documents
  Future<List<Document>> getRecentDocuments({int limit = 10}) {
    return (select(documents)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }

  /// Search documents by text
  Future<List<Document>> searchDocuments(String query) async {
    return (select(documents)
          ..where((tbl) =>
              tbl.title.contains(query) |
              tbl.extractedText.contains(query) |
              tbl.tags.contains(query)))
        .get();
  }

  /// Get document by id
  Future<Document?> getDocumentById(int id) {
    return (select(documents)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Create new document
  Future<int> createDocument(DocumentsCompanion document) {
    return into(documents).insert(document);
  }

  /// Update document
  Future<bool> updateDocument(Document document) {
    return update(documents).replace(document);
  }

  /// Delete document
  Future<int> deleteDocument(int id) {
    return (delete(documents)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Get all categories
  Future<List<Category>> getAllCategories() {
    return (select(categories)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get();
  }

  /// Get reminders for document
  Future<List<Reminder>> getRemindersForDocument(int documentId) {
    return (select(reminders)..where((tbl) => tbl.documentId.equals(documentId))).get();
  }

  /// Get upcoming reminders
  Future<List<Reminder>> getUpcomingReminders() {
    final now = DateTime.now();
    return (select(reminders)
          ..where((tbl) => tbl.reminderDate.isBiggerThanValue(now) & tbl.isCompleted.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.reminderDate)]))
        .get();
  }

  /// Get extracted data for document
  Future<List<ExtractedDataData>> getExtractedDataForDocument(int documentId) {
    return (select(extractedData)..where((tbl) => tbl.documentId.equals(documentId))).get();
  }

  /// Get notes for document
  Future<List<UserNote>> getNotesForDocument(int documentId) {
    return (select(userNotes)
          ..where((tbl) => tbl.documentId.equals(documentId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Get document count by category
  Future<int> getDocumentCountByCategory(String category) async {
    final count = countAll();
    final query = selectOnly(documents)
      ..where(documents.category.equals(category))
      ..addColumns([count]);
    final result = await query.getSingleOrNull();
    return result?.read(count) ?? 0;
  }

  /// Get total storage used
  Future<int> getTotalStorageUsed() async {
    final sum = documents.fileSizeBytes.sum();
    final query = selectOnly(documents)..addColumns([sum]);
    final result = await query.getSingleOrNull();
    return result?.read(sum) ?? 0;
  }
}

/// Open encrypted database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, AppConstants.databaseName));

    // Setup SQLite for Android
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Get or create encryption key
    final secureStorage = const FlutterSecureStorage();
    String? encryptionKey = await secureStorage.read(key: AppConstants.dbEncryptionKeyName);

    if (encryptionKey == null) {
      encryptionKey = _generateEncryptionKey();
      await secureStorage.write(
        key: AppConstants.dbEncryptionKeyName,
        value: encryptionKey,
      );
    }

    return NativeDatabase(
      file,
      setup: (rawDb) {
        // Enable foreign keys
        rawDb.execute('PRAGMA foreign_keys = ON;');

        // Note: SQLCipher encryption would be configured here
        // For production, use sqlcipher_flutter_libs package
        // rawDb.execute("PRAGMA key = '$encryptionKey';");
      },
    );
  });
}

/// Generate a secure random encryption key
String _generateEncryptionKey() {
  final random = Random.secure();
  final bytes = List<int>.generate(32, (_) => random.nextInt(256));
  return base64Url.encode(bytes);
}

