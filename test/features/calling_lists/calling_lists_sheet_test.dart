import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/arrow_box_button.dart';
import 'package:calley_app/features/calling_lists/domain/entities/calling_list.dart';
import 'package:calley_app/features/calling_lists/domain/repositories/calling_list_repository.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/get_calling_lists.dart';
import 'package:calley_app/features/calling_lists/domain/usecases/refresh_calling_lists.dart';
import 'package:calley_app/features/calling_lists/presentation/providers/calling_list_provider.dart';
import 'package:calley_app/features/calling_lists/presentation/widgets/calling_list_tile.dart';
import 'package:calley_app/features/calling_lists/presentation/widgets/calling_lists_sheet.dart';
import 'package:calley_app/features/calling_lists/presentation/widgets/refresh_button.dart';

import 'package:calley_app/features/dashboard/domain/entities/call_stats.dart';
import 'package:calley_app/features/dashboard/domain/entities/dashboard_info.dart';
import 'package:calley_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_call_stats.dart';
import 'package:calley_app/features/dashboard/domain/usecases/get_dashboard_info.dart';
import 'package:calley_app/features/dashboard/presentation/providers/dashboard_provider.dart';

class _FakeRepo implements CallingListRepository {
  _FakeRepo({this.initial = const [CallingList(id: '1', name: AppStrings.testList, totalCalls: 50)]});
  final List<CallingList> initial;
  @override
  Future<List<CallingList>> getLists() async => initial;
  @override
  Future<List<CallingList>> refresh() async => initial;
}

class _FakeDashRepo implements DashboardRepository {
  @override
  Future<DashboardInfo> getDashboardInfo() async => const DashboardInfo(cardTitle: '', message: '', link: '');
  @override
  Future<CallStats> getStats(String listId, [String? listName]) async => const CallStats(listName: '', totalCalls: 0, pending: 0, done: 0, scheduled: 0);
}

Widget _wrapSheet({required CallingListProvider provider, ValueChanged<CallingList>? onSelected}) {
  final dashP = DashboardProvider(getDashboardInfo: GetDashboardInfo(_FakeDashRepo()), getCallStats: GetCallStats(_FakeDashRepo()));
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<CallingListProvider>.value(value: provider),
      ChangeNotifierProvider<DashboardProvider>.value(value: dashP),
    ],
    child: MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        body: CallingListsSheet(onListSelected: onSelected),
      ),
    ),
  );
}

void main() {
  testWidgets('renders CallingListsSheet with items and refresh button', (tester) async {
    final provider = CallingListProvider(
      getCallingLists: GetCallingLists(_FakeRepo()),
      refreshCallingLists: RefreshCallingLists(_FakeRepo()),
    );
    await provider.load();

    await tester.pumpWidget(_wrapSheet(provider: provider));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.callingListsBand), findsOneWidget);
    expect(find.text(AppStrings.selectCallingList), findsOneWidget);
    expect(find.byType(RefreshButton), findsOneWidget);
    expect(find.byType(CallingListTile), findsOneWidget);
    expect(find.text(AppStrings.testList), findsOneWidget);
    expect(find.byType(ArrowBoxButton), findsOneWidget);
  });

  testWidgets('tapping list tile fires onListSelected callback', (tester) async {
    CallingList? selected;
    final provider = CallingListProvider(
      getCallingLists: GetCallingLists(_FakeRepo()),
      refreshCallingLists: RefreshCallingLists(_FakeRepo()),
    );
    await provider.load();

    await tester.pumpWidget(_wrapSheet(
      provider: provider,
      onSelected: (list) => selected = list,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.testList));
    await tester.pumpAndSettle();

    expect(selected?.name, AppStrings.testList);
  });

  testWidgets('empty state displays when no lists present', (tester) async {
    final provider = CallingListProvider(
      getCallingLists: GetCallingLists(_FakeRepo(initial: const [])),
      refreshCallingLists: RefreshCallingLists(_FakeRepo(initial: const [])),
    );
    await provider.load();

    await tester.pumpWidget(_wrapSheet(provider: provider));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.noCallingLists), findsOneWidget);
  });
}
