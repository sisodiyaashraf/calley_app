import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/navigation/app_router.dart';
import 'package:calley_app/core/navigation/initial_route.dart';
import 'package:calley_app/core/session/session.dart';
import 'package:calley_app/core/session/session_storage.dart';
import 'package:calley_app/features/dashboard/presentation/pages/dashboard_load_page.dart';
import 'package:calley_app/features/dashboard/presentation/pages/static_chart_page.dart';
import 'package:calley_app/features/language/presentation/pages/choose_language_page.dart';
import '../test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() { SharedPreferences.setMockInitialValues({}); Session.instance.clear(); });

  testWidgets('Target Flows D, E, F verification', (tester) async {
    tester.view.physicalSize = const Size(368, 729);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await SessionStorage.save('John Doe', 'john@example.com');
    Session.instance.update(newName: 'John Doe', newEmail: 'john@example.com');

    // Launch directly to main shell (DashboardLoadPage)
    await tester.pumpWidget(createFlowTestApp(AppRoutes.main));
    await tester.pumpAndSettle();

    expect(find.byType(DashboardLoadPage), findsOneWidget);

    // Flow D: Headset icon opens StaticChartPage
    await tester.tap(find.byIcon(Icons.headset_mic_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(StaticChartPage), findsOneWidget);
    expect(find.text('50'), findsOneWidget);
    expect(find.text('28'), findsOneWidget);
    expect(find.text('22'), findsOneWidget);
    expect(find.text('09'), findsOneWidget);

    // Flow E: Back returns to DashboardLoadPage
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(DashboardLoadPage), findsOneWidget);

    // Flow F: Drawer -> Logout -> Language page
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text(AppStrings.drawerLogout), 100.0, scrollable: find.byType(Scrollable).last);
    await tester.tap(find.text(AppStrings.drawerLogout));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, AppStrings.drawerLogout));
    await tester.pumpAndSettle();
    expect(find.byType(ChooseLanguagePage), findsOneWidget);

    var data = await SessionStorage.load();
    expect(data.isLoggedIn, isFalse);

    // Close and reopen -> Language page
    Session.instance.clear();
    await tester.pumpWidget(createFlowTestApp(resolveInitialRoute(data.isLoggedIn)));
    await tester.pumpAndSettle();
    expect(find.byType(ChooseLanguagePage), findsOneWidget);
  });
}
