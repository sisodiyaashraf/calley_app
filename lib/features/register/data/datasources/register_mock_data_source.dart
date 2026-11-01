import '../../domain/entities/register_request.dart';

/// Fake data source that simulates a 1-second network round-trip.
/// Replace with a real HTTP call (e.g. Dio/http) when the backend is ready.
class RegisterMockDataSource {
  const RegisterMockDataSource();

  Future<bool> register(RegisterRequest request) async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(seconds: 1));
    // Always returns success; throw an Exception here to simulate errors.
    return true;
  }
}
