import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/navigation/nav_provider.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/dashboard_app_bar.dart';
import 'package:calley_app/core/widgets/primary_button.dart';
import 'package:calley_app/features/calling_lists/domain/entities/calling_list.dart';
import 'package:calley_app/features/calling_lists/domain/repositories/calling_list_repository.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/get_calling_lists.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/refresh_calling_lists.dart';
import 'package:calley_app/features/calling_lists/presentation/providers/calling_list_provider.dart';
import 'package:calley_app/features/dashboard/presentation/pages/dashboard_chart_page.dart';
import 'package:calley_app/features/dashboard/presentation/pages/dashboard_load_page.dart';
import 'package:calley_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:calley_app/features/dashboard/presentation/widgets/call_donut_chart.dart';
import 'package:calley_app/features/dashboard/presentation/widgets/selected_list_card.dart';
import 'package:calley_app/features/dashboard/presentation/widgets/stats_row.dart';
import 'package:calley_app/features/home/domain/entities/user_profile.dart';
import 'package:calley_app/features/home/domain/repositories/home_repository.dart';
import 'package:calley_app/features/home/domain/usecases/get_user_profile.dart';
import 'package:calley_app/features/home/presentation/providers/home_provider.dart';

class _FakeHomeRepo implements HomeRepository {
  @override
  Future<UserProfile> getProfile() async => const UserProfile(name: 'Swati', title: 'Calley Personal');
}

class _FakeCallingListRepo implements CallingListRepository {
  @override
  Future<List<CallingList>> getLists() async => const [
        CallingList(id: '1', name: AppStrings.testList, totalCalls: 50),
      ];
  @override
  Future<List<CallingList>> refresh() async => const [];
}

Widget _createTestWidget({VoidCallback? onMenu, VoidCallback? onSupport, VoidCallback? onNotifications, VoidCallback? onStartCalling}) {
  return MaterialApp(
    theme: AppTheme.light,
    home: DashboardChartPage(
      onMenuTapped: onMenu,
      onSupportTapped: onSupport,
      onNotificationsTapped: onNotifications,
      onStartCallingTapped: onStartCalling,
    ),
  );
}

void main() {
  testWidgets('renders static Dashboard chart elements on 367x729 frame', (tester) async {
    tester.view.physicalSize = const Size(367, 729);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byType(DashboardAppBar), findsOneWidget);
    expect(find.text(AppStrings.dashboardTitle), findsOneWidget);
    expect(find.byType(SelectedListCard), findsOneWidget);
    expect(find.text(AppStrings.testList), findsOneWidget);
    expect(find.text('50'), findsOneWidget);
    expect(find.text(AppStrings.callsCaps), findsOneWidget);
    expect(find.byType(CallDonutChart), findsOneWidget);
    expect(find.byType(StatsRow), findsOneWidget);
    expect(find.text(AppStrings.pendingLabel), findsOneWidget);
    expect(find.text('28'), findsOneWidget);
    expect(find.text(AppStrings.doneLabel), findsOneWidget);
    expect(find.text('22'), findsOneWidget);
    expect(find.text(AppStrings.scheduleLabel), findsOneWidget);
    expect(find.text('09'), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
    expect(find.text(AppStrings.startCallingNow), findsOneWidget);
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

  testWidgets('DashboardPage retains DashboardLoadPage on start even when calling list is preloaded', (tester) async {
    final navP = NavProvider(initialIndex: 2, initialShowChart: false);
    final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
    final listP = CallingListProvider(
      getCallingLists: GetCallingLists(_FakeCallingListRepo()),
      refreshCallingLists: RefreshCallingLists(_FakeCallingListRepo()),
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: navP),
          ChangeNotifierProvider.value(value: homeP),
          ChangeNotifierProvider.value(value: listP),
        ],
        child: const MaterialApp(
          home: DashboardPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify list was loaded and auto-selected
    expect(listP.selected, isNotNull);
    // Despite selected != null, showChart is false, so DashboardLoadPage must be shown
    expect(find.byType(DashboardLoadPage), findsOneWidget);
    expect(find.text(AppStrings.loadNumberToCall), findsOneWidget);
    expect(find.byType(CallDonutChart), findsNothing);
    expect(find.byType(DashboardChartPage), findsNothing);

    // When showChart is explicitly toggled true, it transitions to chart
    navP.setShowChart(true);
    await tester.pumpAndSettle();
    expect(find.byType(DashboardChartPage), findsOneWidget);
    expect(find.byType(CallDonutChart), findsOneWidget);
    expect(find.byType(DashboardLoadPage), findsNothing);
  });
}
