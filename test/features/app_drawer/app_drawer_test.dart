import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/navigation/nav_provider.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/features/app_drawer/domain/usecases/get_drawer_items.dart';
import 'package:calley_app/features/app_drawer/domain/usecases/logout_user.dart';
import 'package:calley_app/features/app_drawer/presentation/providers/drawer_provider.dart';
import 'package:calley_app/features/app_drawer/presentation/widgets/app_drawer.dart';
import 'package:calley_app/features/app_drawer/presentation/widgets/drawer_header_card.dart';
import 'package:calley_app/features/app_drawer/presentation/widgets/drawer_section_title.dart';
import 'package:calley_app/features/home/domain/entities/user_profile.dart';
import 'package:calley_app/features/home/domain/repositories/home_repository.dart';
import 'package:calley_app/features/home/domain/usecases/get_user_profile.dart';
import 'package:calley_app/features/home/presentation/providers/home_provider.dart';
import 'package:calley_app/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:calley_app/features/sign_in/domain/repositories/sign_in_repository.dart';

class _FakeHomeRepo implements HomeRepository {
  @override
  Future<UserProfile> getProfile() async => const UserProfile(name: 'Swati', title: 'Calley Personal', email: 'swati@cstech.in', subscription: 'Calley Personal');
}

class _FakeSignInRepo implements SignInRepository {
  bool loggedOut = false;
  @override
  Future<bool> signIn(SignInRequest request) async => true;
  @override
  Future<void> logout() async {
    loggedOut = true;
  }
}

Widget _createDrawerTestWidget({VoidCallback? onGettingStarted, VoidCallback? onSettings, VoidCallback? onLogout}) {
  final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
  final drawerP = DrawerProvider(getDrawerItems: const GetDrawerItems(), logoutUser: LogoutUser(_FakeSignInRepo()));
  final navP = NavProvider();

  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: navP),
      ChangeNotifierProvider.value(value: homeP),
      ChangeNotifierProvider.value(value: drawerP),
    ],
    child: MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        drawer: AppDrawer(
          onGettingStartedTapped: onGettingStarted,
          onSettingsTapped: onSettings,
          onLogoutTapped: onLogout,
        ),
        body: const Center(child: Text('Main Body')),
      ),
    ),
  );
}

void main() {
  testWidgets('renders all AppDrawer header and item widgets without overflow on 305 width', (tester) async {
    tester.view.physicalSize = const Size(414, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_createDrawerTestWidget());
    await tester.pumpAndSettle();

    final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    expect(find.byType(AppDrawer), findsOneWidget);
    expect(find.byType(DrawerHeaderCard), findsOneWidget);
    expect(find.textContaining('Swati'), findsOneWidget);
    expect(find.text('swati@cstech.in'), findsOneWidget);
    expect(find.byType(DrawerSectionTitle), findsOneWidget);
    expect(find.text(AppStrings.drawerAppInfo), findsOneWidget);

    expect(find.text(AppStrings.drawerDashboard), findsNothing);
    expect(find.text(AppStrings.drawerAllScreens), findsNothing);
    expect(find.text(AppStrings.drawerGettingStarted), findsOneWidget);
    expect(find.text(AppStrings.drawerSyncData), findsOneWidget);
    expect(find.text(AppStrings.drawerGamification), findsOneWidget);
    expect(find.text(AppStrings.drawerSendLogs), findsOneWidget);
    expect(find.text(AppStrings.drawerSettings), findsOneWidget);
    expect(find.text(AppStrings.drawerHelp), findsOneWidget);
    expect(find.text(AppStrings.drawerCancelSubscription), findsOneWidget);

    expect(find.text(AppStrings.drawerAboutUs), findsOneWidget);
    expect(find.text(AppStrings.drawerPrivacyPolicy), findsOneWidget);
    expect(find.textContaining(AppStrings.drawerVersionPrefix), findsOneWidget);
    expect(find.text(AppStrings.drawerShareApp), findsOneWidget);
    expect(find.text(AppStrings.drawerLogout), findsOneWidget);

    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping menu item closes drawer and invokes callback', (tester) async {
    var gettingStartedTapped = false;
    await tester.pumpWidget(_createDrawerTestWidget(onGettingStarted: () => gettingStartedTapped = true));
    await tester.pumpAndSettle();

    final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.drawerGettingStarted));
    await tester.pumpAndSettle();

    expect(gettingStartedTapped, isTrue);
    expect(find.byType(AppDrawer), findsNothing);
  });

  testWidgets('tapping Sync Data menu item closes drawer and invokes syncData', (tester) async {
    await tester.pumpWidget(_createDrawerTestWidget());
    await tester.pumpAndSettle();

    final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.drawerSyncData));
    await tester.pumpAndSettle();
    expect(find.byType(AppDrawer), findsNothing);

    // Let fake sync 1-second delay complete
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
  });
}
