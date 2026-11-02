import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/navigation/app_router.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/features/static_screens/domain/entities/static_screen_data.dart';
import 'package:calley_app/features/static_screens/presentation/pages/static_screen_page.dart';
import 'package:calley_app/features/static_screens/presentation/pages/static_screens_page.dart';
import 'package:calley_app/features/static_screens/presentation/pages/sync_data_page.dart';

void main() {
  testWidgets('StaticScreenPage renders data and button pops screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const StaticScreenPage(data: StaticScreenData.gettingStarted),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Getting Started'), findsWidgets);
    expect(find.text('Learn how to use Calley Automatic Call Dialer'), findsOneWidget);
    expect(find.byIcon(Icons.rocket_launch_outlined), findsOneWidget);
    expect(find.text('Got It'), findsOneWidget);

    await tester.tap(find.text('Got It'));
    await tester.pumpAndSettle();
  });

  testWidgets('StaticScreensPage renders all screen navigation items', (tester) async {
    tester.view.physicalSize = const Size(414, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: const StaticScreensPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.staticScreensTitle), findsOneWidget);
    expect(find.text('PRIMARY APP SCREENS'), findsOneWidget);
    expect(find.text('Screen 1: Choose Language'), findsOneWidget);
    expect(find.text('Screen 2: Register'), findsOneWidget);
    expect(find.text('Screen 3: WhatsApp OTP'), findsOneWidget);
    expect(find.text('Screen 4: Sign In'), findsOneWidget);
    expect(find.text('Screen 5: Home Dashboard'), findsOneWidget);
    expect(find.text('Screen 6: Dashboard & Call Stats'), findsOneWidget);
    expect(find.text('Screen 7: Settings'), findsOneWidget);

    expect(find.text('DRAWER & AUXILIARY STATIC SCREENS'), findsOneWidget);
    expect(find.text('Getting Started'), findsOneWidget);
    expect(find.text('Sync Data'), findsOneWidget);
    expect(find.text('Gamification'), findsOneWidget);
    expect(find.text('Send Logs'), findsOneWidget);
    expect(find.text('Help & Support'), findsOneWidget);
  });

  testWidgets('SyncDataPage renders sync categories and handles sync action', (tester) async {
    tester.view.physicalSize = const Size(414, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: SyncDataPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.drawerSyncData), findsOneWidget);
    expect(find.text('Calley Cloud Sync'), findsOneWidget);
    expect(find.text('Calling Lists'), findsOneWidget);
    expect(find.text('Call Logs & Audio'), findsOneWidget);
    expect(find.text('Dispositions & Feedback'), findsOneWidget);
    expect(find.text('Sync over Wi-Fi only'), findsOneWidget);
    expect(find.text('Sync Now'), findsOneWidget);

    await tester.tap(find.text('Sync Now'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    expect(find.text('All lists and call records synchronized!'), findsOneWidget);
  });
}
