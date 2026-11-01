import '../entities/user_profile.dart';

/// Repository interface for home dashboard and user profile data.
abstract class HomeRepository {
  Future<UserProfile> getProfile();
}
