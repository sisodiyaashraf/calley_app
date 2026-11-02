import '../../domain/entities/user_profile.dart';

/// Mock data source providing home dashboard profile information.
class HomeMockDataSource {
  const HomeMockDataSource();

  Future<UserProfile> getProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return const UserProfile(
      name: '',
      title: 'Calley Personal',
      email: '',
      phone: '',
      parentAccount: 'NA',
      subscription: 'Calley Personal',
    );
  }
}
