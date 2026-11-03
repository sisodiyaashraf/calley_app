import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/navigation/initial_route.dart';
import 'package:calley_app/core/session/session.dart';
import 'package:calley_app/core/session/session_storage.dart';
import 'package:calley_app/features/dashboard/presentation/pages/dashboard_load_page.dart';
import 'package:calley_app/features/home/presentation/pages/first_time_home_page.dart';
import 'package:calley_app/features/language/presentation/pages/choose_language_page.dart';
import 'package:calley_app/features/otp/presentation/pages/otp_page.dart';
import 'package:calley_app/features/otp/presentation/providers/otp_provider.dart';
import 'package:calley_app/features/register/presentation/pages/register_page.dart';
import 'package:calley_app/features/register/presentation/providers/register_provider.dart';
import '../test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() { SharedPreferences.setMockInitialValues({}); Session.instance.clear(); });

  testWidgets('Target Flows A, B, C verification', (tester) async {
    tester.view.physicalSize = const Size(368, 729);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Flow A: Fresh install -> Language -> Register -> OTP -> FirstTimeHome
    var data = await SessionStorage.load();
    expect(data.isLoggedIn, isFalse);
    await tester.pumpWidget(createFlowTestApp(resolveInitialRoute(data.isLoggedIn)));
    await tester.pumpAndSettle();
    expect(find.byType(ChooseLanguagePage), findsOneWidget);

    await tester.tap(find.text(AppStrings.select));
    await tester.pumpAndSettle();
    expect(find.byType(RegisterPage), findsOneWidget);

    final reg = tester.element(find.byType(RegisterPage)).read<RegisterProvider>();
    reg.setName('John Doe');
    reg.setEmail('john@example.com');
    reg.setPassword('Password123!');
    reg.setPhone('9876543210');
    reg.toggleTerms();
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.signUp));
    await tester.pumpAndSettle();
    expect(find.byType(OtpPage), findsOneWidget);

    tester.element(find.byType(OtpPage)).read<OtpProvider>().setCode('123456');
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.verify));
    await tester.pumpAndSettle();

    expect(find.byType(FirstTimeHomePage), findsOneWidget);
    expect(find.textContaining('John Doe'), findsOneWidget);

    data = await SessionStorage.load();
    expect(data.isLoggedIn, isTrue);
    expect(data.name, 'John Doe');

    // Flow B: Reopen while logged in -> FirstTimeHomePage directly
    Session.instance.clear();
    Session.instance.update(newName: data.name, newEmail: data.email);
    await tester.pumpWidget(createFlowTestApp(resolveInitialRoute(data.isLoggedIn)));
    await tester.pumpAndSettle();
    expect(find.byType(FirstTimeHomePage), findsOneWidget);
    expect(find.textContaining('John Doe'), findsOneWidget);

    // Flow C: Start Calling Now -> MainShell with DashboardLoadPage and bottom nav
    await tester.tap(find.text(AppStrings.startCallingNow));
    await tester.pumpAndSettle();
    expect(find.byType(DashboardLoadPage), findsOneWidget);
    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
  });
}
