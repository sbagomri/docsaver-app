/// Base class for all app exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AppException(this.message, {this.code, this.originalError});

  @override
  String toString() => message;
}

/// Database related exceptions
class DatabaseException extends AppException {
  DatabaseException(super.message, {super.code, super.originalError});
}

/// File system exceptions
class FileSystemException extends AppException {
  FileSystemException(super.message, {super.code, super.originalError});
}

/// Encryption/Decryption exceptions
class EncryptionException extends AppException {
  EncryptionException(super.message, {super.code, super.originalError});
}

/// Authentication exceptions
class AuthenticationException extends AppException {
  AuthenticationException(super.message, {super.code, super.originalError});
}

/// OCR processing exceptions
class OCRException extends AppException {
  OCRException(super.message, {super.code, super.originalError});
}

/// Network/Sync exceptions
class SyncException extends AppException {
  SyncException(super.message, {super.code, super.originalError});
}

/// Validation exceptions
class ValidationException extends AppException {
  ValidationException(super.message, {super.code, super.originalError});
}

