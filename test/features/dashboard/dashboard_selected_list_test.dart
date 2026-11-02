import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/primary_button.dart';
import 'package:calley_app/core/widgets/whatsapp_action_button.dart';
import 'package:calley_app/features/calling_lists/domain/entities/calling_list.dart';
import 'package:calley_app/features/calling_lists/domain/repositories/calling_list_repository.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/get_calling_lists.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/refresh_calling_lists.dart';
import 'package:calley_app/features/calling_lists/presentation/providers/calling_list_provider.dart';
import 'package:calley_app/features/calling_lists/presentation/widgets/calling_lists_sheet.dart';
import 'package:calley_app/features/dashboard/domain/entities/call_stats.dart';
import 'package:calley_app/features/dashboard/domain/entities/dashboard_info.dart';
import 'package:calley_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_call_stats.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_dashboard_info.dart';
import 'package:calley_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:calley_app/features/dashboard/presentation/providers/dashboard_provider.dart';
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

class _FakeDashboardRepo implements DashboardRepository {
  @override
  Future<DashboardInfo> getDashboardInfo() async => const DashboardInfo(cardTitle: AppStrings.loadNumberToCall, message: AppStrings.loadNumberMessage, link: AppStrings.loadNumberUrl);
  @override
  Future<CallStats> getStats(String listId, [String? listName]) async => const CallStats(listName: AppStrings.testList, totalCalls: 50, pending: 28, done: 22, scheduled: 9);
}

class _FakeCallingListRepo implements CallingListRepository {
  @override
  Future<List<CallingList>> getLists() async => const [CallingList(id: '1', name: AppStrings.testList, totalCalls: 50)];
  @override
  Future<List<CallingList>> refresh() async => const [];
}

Widget _createSelectedWidget({VoidCallback? onCall}) {
  final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
  final dashRepo = _FakeDashboardRepo();
  final dashP = DashboardProvider(getDashboardInfo: GetDashboardInfo(dashRepo), getCallStats: GetCallStats(dashRepo));
  final listP = CallingListProvider(getCallingLists: GetCallingLists(_FakeCallingListRepo()), refreshCallingLists: RefreshCallingLists(_FakeCallingListRepo()));
  listP.select(const CallingList(id: '1', name: AppStrings.testList, totalCalls: 50));

  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: homeP),
      ChangeNotifierProvider.value(value: dashP),
      ChangeNotifierProvider.value(value: listP),
    ],
    child: MaterialApp(
      theme: AppTheme.light,
      home: DashboardPage(onStartCallingTapped: onCall),
    ),
  );
}

void main() {
  testWidgets('renders all selected calling list dashboard elements', (tester) async {
    tester.view.physicalSize = const Size(368, 700);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_createSelectedWidget());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.byType(SelectedListCard), findsOneWidget);
    expect(find.text(AppStrings.testList), findsOneWidget);
    expect(find.text('50'), findsOneWidget);
    expect(find.text(AppStrings.callsCaps), findsOneWidget);
    expect(find.text('T'), findsOneWidget);

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
    expect(find.byType(WhatsAppActionButton), findsNothing);
  });

  testWidgets('tapping selected list card opens calling lists sheet', (tester) async {
    tester.view.physicalSize = const Size(368, 700);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_createSelectedWidget());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(SelectedListCard));
    await tester.pumpAndSettle();

    expect(find.byType(CallingListsSheet), findsOneWidget);
  });

  testWidgets('fits on 360x640 frame and scrolls without overflow on compact screen', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_createSelectedWidget());
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(SelectedListCard), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
  });
}
