import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../models/auth_user_model.dart';

/// Remote data source handling user authentication via Mock API V2.
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<AuthUserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      '/auth/login',
      body: {'email': email, 'password': password},
    );

    if (response is Map<String, dynamic>) {
      if (response['user'] is Map<String, dynamic>) {
        return AuthUserModel.fromJson(response['user'] as Map<String, dynamic>);
      }
      return AuthUserModel.fromJson(response);
    }
    throw const AppException('Invalid login response from server');
  }
}
