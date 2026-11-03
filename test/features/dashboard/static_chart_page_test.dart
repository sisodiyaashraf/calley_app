import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outline_pie_chart/outline_pie_chart.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/dashboard_app_bar.dart';
import 'package:calley_app/core/widgets/primary_button.dart';
import 'package:calley_app/features/dashboard/presentation/pages/static_chart_page.dart';
import 'package:calley_app/features/dashboard/presentation/widgets/call_donut_chart.dart';
import 'package:calley_app/features/dashboard/presentation/widgets/selected_list_card.dart';
import 'package:calley_app/features/dashboard/presentation/widgets/stats_row.dart';

Widget _buildTestApp({VoidCallback? onMenu}) {
  return MaterialApp(
    theme: AppTheme.light,
    home: StaticChartPage(onMenuTapped: onMenu),
  );
}

void main() {
  testWidgets('StaticChartPage renders all static elements without overflow', (tester) async {
    tester.view.physicalSize = const Size(368, 729);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(DashboardAppBar), findsOneWidget);
    expect(find.text(AppStrings.dashboardTitle), findsOneWidget);
    expect(find.byType(SelectedListCard), findsOneWidget);
    expect(find.text(AppStrings.testList), findsOneWidget);
    expect(find.text('50'), findsOneWidget);
    expect(find.text(AppStrings.callsCaps), findsOneWidget);
    expect(find.byType(CallDonutChart), findsOneWidget);
    expect(find.byType(PieChartWidget), findsOneWidget);
    expect(find.byType(StatsRow), findsOneWidget);
    expect(find.text(AppStrings.pendingLabel), findsOneWidget);
    expect(find.text('28'), findsOneWidget);
    expect(find.text(AppStrings.doneLabel), findsOneWidget);
    expect(find.text('22'), findsOneWidget);
    expect(find.text(AppStrings.scheduleLabel), findsOneWidget);
    expect(find.text('09'), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
    expect(find.text(AppStrings.startCallingNow), findsOneWidget);
    expect(find.text('Showing sample data'), findsNothing);
  });

  testWidgets('StaticChartPage has zero overflow on small screen', (tester) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_buildTestApp());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
