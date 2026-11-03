import '../../domain/entities/auth_user.dart';

/// Data model representing the authenticated user payload.
class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.id,
    required super.username,
    required super.email,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      username: (json['username'] ?? '') as String,
      email: (json['email'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'username': username,
    'email': email,
  };
}
