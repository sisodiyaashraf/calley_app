import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/dashboard_app_bar.dart';
import 'package:calley_app/core/widgets/profile_header_card.dart';
import 'package:calley_app/core/widgets/start_calling_bar.dart';
import 'package:calley_app/features/calling_lists/domain/entities/calling_list.dart';
import 'package:calley_app/features/calling_lists/domain/repositories/calling_list_repository.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/get_calling_lists.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/refresh_calling_lists.dart';
import 'package:calley_app/features/calling_lists/presentation/providers/calling_list_provider.dart';
import 'package:calley_app/features/dashboard/domain/entities/call_stats.dart';
import 'package:calley_app/features/dashboard/domain/entities/dashboard_info.dart';
import 'package:calley_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_call_stats.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_dashboard_info.dart';
import 'package:calley_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:calley_app/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:calley_app/features/dashboard/presentation/widgets/load_number_card.dart';
import 'package:calley_app/features/home/domain/entities/user_profile.dart';
import 'package:calley_app/features/home/domain/repositories/home_repository.dart';
import 'package:calley_app/features/home/domain/usecases/get_user_profile.dart';
import 'package:calley_app/features/home/presentation/providers/home_provider.dart';

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

Widget _createTestWidget({VoidCallback? onMenu, VoidCallback? onSupport, VoidCallback? onNotifications, VoidCallback? onLink, VoidCallback? onWhatsApp, VoidCallback? onStartCalling}) {
  final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
  final dashRepo = _FakeDashboardRepo();
  final dashP = DashboardProvider(getDashboardInfo: GetDashboardInfo(dashRepo), getCallStats: GetCallStats(dashRepo));
  final listP = CallingListProvider(getCallingLists: GetCallingLists(_FakeCallingListRepo()), refreshCallingLists: RefreshCallingLists(_FakeCallingListRepo()));

  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: homeP),
      ChangeNotifierProvider.value(value: dashP),
      ChangeNotifierProvider.value(value: listP),
    ],
    child: MaterialApp(
      theme: AppTheme.light,
      home: DashboardPage(
        onMenuTapped: onMenu, onSupportTapped: onSupport, onNotificationsTapped: onNotifications,
        onLinkTapped: onLink, onWhatsAppTapped: onWhatsApp, onStartCallingTapped: onStartCalling,
      ),
    ),
  );
}

void main() {
  testWidgets('renders unselected Dashboard elements on 367x729 frame', (tester) async {
    tester.view.physicalSize = const Size(367, 729);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byType(DashboardAppBar), findsOneWidget);
    expect(find.text(AppStrings.dashboardTitle), findsOneWidget);
    expect(find.byType(ProfileHeaderCard), findsOneWidget);
    expect(find.byType(LoadNumberCard), findsOneWidget);
    expect(find.byType(StartCallingBar), findsOneWidget);
  });

  testWidgets('zero overflow errors on compact screen', (tester) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_createTestWidget());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(DashboardAppBar), findsOneWidget);
  });

  testWidgets('app bar icons are positioned safely below status bar notch', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    tester.view.padding = const FakeViewPadding(top: 44, bottom: 34);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPadding);

    await tester.pumpWidget(_createTestWidget());
    await tester.pumpAndSettle();

    final menuIcon = tester.getTopLeft(find.byIcon(Icons.menu));
    expect(menuIcon.dy, greaterThanOrEqualTo(44.0));
  });
}
