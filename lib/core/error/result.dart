import 'exceptions.dart';

/// Represents the result of an operation that can fail
class Result<T> {
  final T? data;
  final AppException? error;

  Result._({this.data, this.error});

  factory Result.success(T data) => Result._(data: data);
  factory Result.failure(AppException error) => Result._(error: error);

  bool get isSuccess => error == null;
  bool get isFailure => error != null;

  /// Transform the data if successful
  Result<R> map<R>(R Function(T data) transform) {
    if (isSuccess) {
      try {
        return Result.success(transform(data as T));
      } catch (e) {
        return Result.failure(
          ValidationException('Transformation failed: $e', originalError: e),
        );
      }
    }
    return Result.failure(error!);
  }

  /// Execute callback on success
  void onSuccess(void Function(T data) callback) {
    if (isSuccess) callback(data as T);
  }

  /// Execute callback on failure
  void onFailure(void Function(AppException error) callback) {
    if (isFailure) callback(error!);
  }

  /// Get data or throw error
  T getOrThrow() {
    if (isSuccess) return data as T;
    throw error!;
  }

  /// Get data or return default value
  T getOrDefault(T defaultValue) {
    return isSuccess ? data as T : defaultValue;
  }
}

