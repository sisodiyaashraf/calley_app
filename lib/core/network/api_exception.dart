import 'dart:async';
import 'dart:io';

/// Application exception with user-safe error messages.
class AppException implements Exception {
  const AppException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;

  /// Translates raw exceptions into user-safe error messages.
  factory AppException.from(dynamic error) {
    if (error is AppException) return error;
    if (error is TimeoutException) {
      return const AppException('Request timed out');
    }
    if (error is SocketException) {
      return const AppException('No internet connection');
    }
    return AppException(error?.toString() ?? 'Something went wrong');
  }

  factory AppException.fromStatus(int statusCode) {
    return AppException('Something went wrong ($statusCode)', statusCode: statusCode);
  }
}
