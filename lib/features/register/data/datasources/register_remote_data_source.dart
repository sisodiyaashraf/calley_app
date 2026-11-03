import '../../../../core/network/api_client.dart';

/// Remote data source calling the mock registration API.
class RegisterRemoteDataSource {
  const RegisterRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    await _apiClient.post(
      '/auth/register',
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );
    return true;
  }
}
