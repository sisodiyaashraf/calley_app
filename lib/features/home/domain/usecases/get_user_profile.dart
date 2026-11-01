import '../entities/user_profile.dart';
import '../repositories/home_repository.dart';

/// Use case that fetches the active user profile.
class GetUserProfile {
  const GetUserProfile(this._repository);

  final HomeRepository _repository;

  Future<UserProfile> call() => _repository.getProfile();
}
