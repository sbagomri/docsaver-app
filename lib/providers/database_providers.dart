import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/database/database.dart';

/// Provider for the app database instance
final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});

/// Provider for all documents
final documentsProvider = FutureProvider<List<Document>>((ref) async {
  final database = ref.watch(databaseProvider);
  return database.getAllDocuments();
});

/// Provider for recent documents
final recentDocumentsProvider = FutureProvider<List<Document>>((ref) async {
  final database = ref.watch(databaseProvider);
  return database.getRecentDocuments(limit: 10);
});

/// Provider for favorite documents
final favoriteDocumentsProvider = FutureProvider<List<Document>>((ref) async {
  final database = ref.watch(databaseProvider);
  return database.getFavoriteDocuments();
});

/// Provider for all categories
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final database = ref.watch(databaseProvider);
  return database.getAllCategories();
});

/// Provider for upcoming reminders
final upcomingRemindersProvider = FutureProvider<List<Reminder>>((ref) async {
  final database = ref.watch(databaseProvider);
  return database.getUpcomingReminders();
});

/// Provider for document count by category
final documentCountProvider = FutureProvider.family<int, String>((ref, category) async {
  final database = ref.watch(databaseProvider);
  return database.getDocumentCountByCategory(category);
});

/// Provider for total storage used
final totalStorageProvider = FutureProvider<int>((ref) async {
  final database = ref.watch(databaseProvider);
  return database.getTotalStorageUsed();
});

