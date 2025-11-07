/// String validation and formatting utilities
class StringUtils {
  /// Check if string is null or empty
  static bool isNullOrEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Capitalize first letter of string
  static String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  /// Capitalize first letter of each word
  static String capitalizeWords(String value) {
    if (value.isEmpty) return value;
    return value.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// Truncate string to max length with ellipsis
  static String truncate(String value, int maxLength, {String ellipsis = '...'}) {
    if (value.length <= maxLength) return value;
    return value.substring(0, maxLength - ellipsis.length) + ellipsis;
  }

  /// Remove all whitespace from string
  static String removeWhitespace(String value) {
    return value.replaceAll(RegExp(r'\s+'), '');
  }

  /// Check if string contains only numbers
  static bool isNumeric(String value) {
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }

  /// Check if string is valid email
  static bool isValidEmail(String value) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(value);
  }

  /// Generate a slug from string (lowercase, hyphens)
  static String slugify(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'[\s_-]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

  /// Extract initials from name (e.g., "John Doe" -> "JD")
  static String getInitials(String name, {int maxLength = 2}) {
    final words = name.trim().split(RegExp(r'\s+'));
    final initials = words
        .take(maxLength)
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join();
    return initials;
  }

  /// Format file size from bytes
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  /// Mask sensitive data (e.g., credit card numbers)
  static String maskString(String value, {int visibleChars = 4, String maskChar = '*'}) {
    if (value.length <= visibleChars) return value;
    final masked = maskChar * (value.length - visibleChars);
    return masked + value.substring(value.length - visibleChars);
  }
}

