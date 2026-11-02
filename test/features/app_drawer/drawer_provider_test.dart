import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/features/app_drawer/domain/usecases/get_drawer_items.dart';
import 'package:calley_app/features/app_drawer/domain/usecases/logout_user.dart';
import 'package:calley_app/features/app_drawer/presentation/providers/drawer_provider.dart';
import 'package:calley_app/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:calley_app/features/sign_in/domain/repositories/sign_in_repository.dart';

class _FakeSignInRepo implements SignInRepository {
  bool didLogout = false;
  @override
  Future<bool> signIn(SignInRequest request) async => true;
  @override
  Future<void> logout() async {
    didLogout = true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('mainItems and appInfoItems return expected items in order', () {
    final repo = _FakeSignInRepo();
    final provider = DrawerProvider(
      getDrawerItems: const GetDrawerItems(),
      logoutUser: LogoutUser(repo),
    );

    final mainItems = provider.mainItems;
    expect(mainItems.length, 7);
    expect(mainItems.any((i) => i.id == 'dashboard'), isFalse);
    expect(mainItems.any((i) => i.id == 'all_screens'), isFalse);
    expect(mainItems[0].label, AppStrings.drawerGettingStarted);
    expect(mainItems[1].label, AppStrings.drawerSyncData);
    expect(mainItems[2].label, AppStrings.drawerGamification);
    expect(mainItems[3].label, AppStrings.drawerSendLogs);
    expect(mainItems[4].label, AppStrings.drawerSettings);
    expect(mainItems[5].label, AppStrings.drawerHelp);
    expect(mainItems[6].label, AppStrings.drawerCancelSubscription);

    final appInfoItems = provider.appInfoItems;
    expect(appInfoItems.length, 5);
    expect(appInfoItems[0].label, AppStrings.drawerAboutUs);
    expect(appInfoItems[1].label, AppStrings.drawerPrivacyPolicy);
    expect(appInfoItems[2].label, contains(AppStrings.drawerVersionPrefix));
    expect(appInfoItems[2].isTappable, false);
    expect(appInfoItems[3].label, AppStrings.drawerShareApp);
    expect(appInfoItems[4].label, AppStrings.drawerLogout);
    expect(appInfoItems[4].isDestructive, true);
  });

  test('onItemTapped updates lastTappedId', () {
    final repo = _FakeSignInRepo();
    final provider = DrawerProvider(
      getDrawerItems: const GetDrawerItems(),
      logoutUser: LogoutUser(repo),
    );

    provider.onItemTapped('settings');
    expect(provider.lastTappedId, 'settings');
  });

  test('logout invokes LogoutUser usecase', () async {
    final repo = _FakeSignInRepo();
    final provider = DrawerProvider(
      getDrawerItems: const GetDrawerItems(),
      logoutUser: LogoutUser(repo),
    );

    await provider.logout();
    expect(repo.didLogout, isTrue);
  });
}
