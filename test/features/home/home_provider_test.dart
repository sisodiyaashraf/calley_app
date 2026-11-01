import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/features/home/domain/entities/user_profile.dart';
import 'package:calley_app/features/home/domain/repositories/home_repository.dart';
import 'package:calley_app/features/home/domain/usecases/get_user_profile.dart';
import 'package:calley_app/features/home/presentation/providers/home_provider.dart';

class _FakeHomeRepo implements HomeRepository {
  @override
  Future<UserProfile> getProfile() async {
    return const UserProfile(
      name: 'Swati',
      title: 'Calley Personal',
    );
  }
}

void main() {
  group('HomeProvider', () {
    test('loads user profile on initialization', () async {
      final repo = _FakeHomeRepo();
      final provider = HomeProvider(getUserProfile: GetUserProfile(repo));

      expect(provider.isLoading, isTrue);

      await Future<void>.delayed(Duration.zero);

      expect(provider.isLoading, isFalse);
      expect(provider.profile?.name, 'Swati');
      expect(provider.profile?.title, 'Calley Personal');
    });
  });
}
