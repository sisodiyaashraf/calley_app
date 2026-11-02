import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_dimens.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/navigation/app_router.dart';
import 'package:calley_app/core/navigation/main_shell.dart';
import 'package:calley_app/core/navigation/nav_provider.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/app_bottom_nav_bar.dart';
import 'package:calley_app/core/widgets/bottom_nav_item.dart';
import 'package:calley_app/core/widgets/start_calling_bar.dart';
import 'package:calley_app/features/app_drawer/domain/usecases/get_drawer_items.dart';
import 'package:calley_app/features/app_drawer/domain/usecases/logout_user.dart';
import 'package:calley_app/features/app_drawer/presentation/providers/drawer_provider.dart';
import 'package:calley_app/features/app_drawer/presentation/widgets/app_drawer.dart';
import 'package:calley_app/features/calling_lists/domain/entities/calling_list.dart';
import 'package:calley_app/features/calling_lists/domain/repositories/calling_list_repository.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/get_calling_lists.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/refresh_calling_lists.dart';
import 'package:calley_app/features/calling_lists/presentation/providers/calling_list_provider.dart';
import 'package:calley_app/features/dashboard/domain/entities/call_stats.dart';
import 'package:calley_app/features/dashboard/domain/entities/dashboard_info.dart';
import 'package:calley_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_dashboard_info.dart';
import 'package:calley_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:calley_app/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:calley_app/features/home/domain/entities/user_profile.dart';
import 'package:calley_app/features/home/domain/repositories/home_repository.dart';
import 'package:calley_app/features/home/domain/usecases/get_user_profile.dart';
import 'package:calley_app/features/home/presentation/pages/home_page.dart';
import 'package:calley_app/features/home/presentation/providers/home_provider.dart';
import 'package:calley_app/features/settings/presentation/pages/settings_page.dart';
import 'package:calley_app/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:calley_app/features/sign_in/domain/repositories/sign_in_repository.dart';

class _FakeHomeRepo implements HomeRepository {
  @override
  Future<UserProfile> getProfile() async => const UserProfile(name: 'Swati', title: 'Calley Personal');
}

class _FakeDashboardRepo implements DashboardRepository {
  @override
  Future<DashboardInfo> getDashboardInfo() async => const DashboardInfo(cardTitle: AppStrings.loadNumberToCall, message: AppStrings.loadNumberMessage, link: AppStrings.loadNumberUrl);
  @override
  Future<CallStats> getStats(String listId, [String? listName]) async => const CallStats(listName: AppStrings.testList, totalCalls: 50, pending: 28, done: 22, scheduled: 9);
}

class _FakeCallingListRepo implements CallingListRepository {
  @override
  Future<List<CallingList>> getLists() async => const [];
  @override
  Future<List<CallingList>> refresh() async => const [];
}

class _FakeSignInRepo implements SignInRepository {
  @override
  Future<bool> signIn(SignInRequest request) async => true;
  @override
  Future<void> logout() async {}
}

Widget _createShellApp({required HomeProvider homeP, required NavProvider navP}) {
  final dashP = DashboardProvider(getDashboardInfo: GetDashboardInfo(_FakeDashboardRepo()));
  final listP = CallingListProvider(getCallingLists: GetCallingLists(_FakeCallingListRepo()), refreshCallingLists: RefreshCallingLists(_FakeCallingListRepo()));
  final drawerP = DrawerProvider(getDrawerItems: const GetDrawerItems(), logoutUser: LogoutUser(_FakeSignInRepo()));
  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: navP),
      ChangeNotifierProvider.value(value: homeP),
      ChangeNotifierProvider.value(value: dashP),
      ChangeNotifierProvider.value(value: listP),
      ChangeNotifierProvider.value(value: drawerP),
    ],
    child: MaterialApp(theme: AppTheme.light, home: const MainShell(), onGenerateRoute: AppRouter.onGenerateRoute),
  );
}

void main() {
  testWidgets('MainShell starts at tab 2 (Play) showing DashboardPage', (tester) async {
    final navP = NavProvider();
    final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
    await tester.pumpWidget(_createShellApp(homeP: homeP, navP: navP));
    await tester.pumpAndSettle();
    expect(navP.selectedIndex, 2);
    expect(find.byType(AppBottomNavBar), findsOneWidget);
    expect(find.byType(DashboardPage), findsOneWidget);
  });

  testWidgets('tapping hamburger in DashboardAppBar opens drawer while bottom nav remains', (tester) async {
    final navP = NavProvider();
    final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
    await tester.pumpWidget(_createShellApp(homeP: homeP, navP: navP));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(AppDrawer), findsOneWidget);
    expect(find.byType(AppBottomNavBar), findsOneWidget);
  });

  testWidgets('tapping tab switches placeholder and tapping start calling switches to dashboard', (tester) async {
    final navP = NavProvider();
    final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
    await tester.pumpWidget(_createShellApp(homeP: homeP, navP: navP));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BottomNavItem).first);
    await tester.pumpAndSettle();
    expect(navP.selectedIndex, 0);
    expect(find.byType(HomePage), findsOneWidget);

    await tester.tap(find.text(AppStrings.startCallingNow).first);
    await tester.pumpAndSettle();
    expect(navP.selectedIndex, 2);
  });

  testWidgets('space exists between AppBottomNavBar and calling buttons on Dashboard and Home tabs', (tester) async {
    final navP = NavProvider();
    final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
    await tester.pumpWidget(_createShellApp(homeP: homeP, navP: navP));
    await tester.pumpAndSettle();

    // On Dashboard tab (default tab 2), StartCallingBar is clearance above nav bar
    final navBarTop = tester.getTopLeft(find.byType(AppBottomNavBar)).dy;
    final startCallingBottomDash = tester.getBottomLeft(find.byType(StartCallingBar)).dy;
    expect(navBarTop - startCallingBottomDash, equals(AppDimens.homeBottomBarBottomClearance));

    // Switch to Home tab (tab 0) where StartCallingBar is used
    await tester.tap(find.byType(BottomNavItem).first);
    await tester.pumpAndSettle();

    final startCallingBottomHome = tester.getBottomLeft(find.byType(StartCallingBar)).dy;
    expect(navBarTop - startCallingBottomHome, equals(AppDimens.homeBottomBarBottomClearance));
  });

  testWidgets('tapping Sync Data in drawer selects Dashboard tab and shows Data synced SnackBar', (tester) async {
    final navP = NavProvider();
    final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
    await tester.pumpWidget(_createShellApp(homeP: homeP, navP: navP));
    await tester.pumpAndSettle();

    // Switch to Home tab (tab 0)
    await tester.tap(find.byType(BottomNavItem).first);
    await tester.pumpAndSettle();
    expect(navP.selectedIndex, 0);

    // Open drawer from Home tab
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(AppDrawer), findsOneWidget);

    // Tap Sync Data item in drawer
    await tester.tap(find.text(AppStrings.drawerSyncData));
    await tester.pumpAndSettle();

    // Drawer is closed and tab is switched to Dashboard (tab 2)
    expect(find.byType(AppDrawer), findsNothing);
    expect(navP.selectedIndex, 2);
    expect(find.byType(DashboardPage), findsOneWidget);

    // After 1 second, SnackBar appears
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Data synced'), findsOneWidget);
  });

  testWidgets('app flow: drawer -> Settings -> back -> drawer -> Sync Data -> Dashboard chart + SnackBar', (tester) async {
    final navP = NavProvider();
    final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
    await tester.pumpWidget(_createShellApp(homeP: homeP, navP: navP));
    await tester.pumpAndSettle();

    // 1. Dashboard shows load number card initially
    expect(find.byType(DashboardPage), findsOneWidget);
    expect(find.text(AppStrings.loadNumberToCall), findsOneWidget);

    // 2. Open drawer -> tap Settings
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(AppDrawer), findsOneWidget);

    await tester.tap(find.text(AppStrings.drawerSettings));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);

    // 3. Go back
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new).first);
    await tester.pumpAndSettle();
    expect(find.byType(DashboardPage), findsOneWidget);

    // 4. Open drawer -> tap Sync Data
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.byType(AppDrawer), findsOneWidget);

    await tester.tap(find.text(AppStrings.drawerSyncData));
    await tester.pumpAndSettle();

    // 5. Drawer closed, dashboard chart shown, SnackBar appears
    expect(find.byType(AppDrawer), findsNothing);
    expect(find.byType(DashboardPage), findsOneWidget);
    expect(find.text(AppStrings.testList), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Data synced'), findsOneWidget);
  });
}
