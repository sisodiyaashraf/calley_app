import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/auth_link_text.dart';
import 'package:calley_app/features/register/domain/entities/register_request.dart';
import 'package:calley_app/features/register/domain/repositories/register_repository.dart';
import 'package:calley_app/features/register/domain/usecases/register_user.dart';
import 'package:calley_app/features/register/presentation/pages/register_page.dart';
import 'package:calley_app/features/register/presentation/providers/register_provider.dart';

class _FakeRepo implements RegisterRepository {
  @override
  Future<bool> register(RegisterRequest request) async => true;
}

Widget createTestableWidget({
  required RegisterProvider provider,
  VoidCallback? onRegistered,
  VoidCallback? onSignInTapped,
}) {
  return ChangeNotifierProvider<RegisterProvider>.value(
    value: provider,
    child: MaterialApp(
      theme: AppTheme.light,
      home: RegisterPage(
        onRegistered: onRegistered,
        onSignInTapped: onSignInTapped,
      ),
    ),
  );
}

void main() {
  testWidgets('renders all Register screen elements without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final provider = RegisterProvider(
      registerUser: RegisterUser(_FakeRepo()),
    );

    await tester.pumpWidget(createTestableWidget(provider: provider));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.welcome), findsOneWidget);
    expect(find.text(AppStrings.registerSubtitle), findsOneWidget);
    expect(find.text(AppStrings.hintName), findsOneWidget);
    expect(find.text(AppStrings.hintEmail), findsOneWidget);
    expect(find.text(AppStrings.hintPassword), findsOneWidget);
    expect(find.text(AppStrings.countryCodeIndia), findsOneWidget);
    expect(find.text(AppStrings.hintMobile), findsOneWidget);
    expect(find.text(AppStrings.signUp), findsOneWidget);
    expect(find.byType(AuthLinkText), findsOneWidget);
    expect(
      find.textContaining(AppStrings.signInLink, findRichText: true),
      findsOneWidget,
    );
  });

  testWidgets('submitting empty form displays error messages',
      (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final provider = RegisterProvider(
      registerUser: RegisterUser(_FakeRepo()),
    );

    await tester.pumpWidget(createTestableWidget(provider: provider));
    await tester.pumpAndSettle();

    // Tap "Sign Up" button
    await tester.tap(find.text(AppStrings.signUp));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.errNameRequired), findsOneWidget);
    expect(find.text(AppStrings.errEmailInvalid), findsOneWidget);
    expect(find.text(AppStrings.errPasswordShort), findsOneWidget);
    expect(find.text(AppStrings.errPhoneInvalid), findsOneWidget);
    expect(find.text(AppStrings.errTermsRequired), findsOneWidget);
  });

  testWidgets('tapping Sign In link fires onSignInTapped', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    bool signInTapped = false;
    final provider = RegisterProvider(
      registerUser: RegisterUser(_FakeRepo()),
    );

    await tester.pumpWidget(createTestableWidget(
      provider: provider,
      onSignInTapped: () => signInTapped = true,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(AuthLinkText));
    await tester.pumpAndSettle();

    expect(signInTapped, isTrue);
  });

  testWidgets('valid form submission triggers onRegistered', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    bool registeredCalled = false;
    final provider = RegisterProvider(
      registerUser: RegisterUser(_FakeRepo()),
      onRegistered: () => registeredCalled = true,
    );

    await tester.pumpWidget(createTestableWidget(provider: provider));
    await tester.pumpAndSettle();

    // Fill form through provider
    provider.setName('Jane Doe');
    provider.setEmail('jane@example.com');
    provider.setPassword('password123');
    provider.setPhone('9876543210');
    provider.toggleTerms();
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.signUp));
    await tester.pumpAndSettle();

    expect(registeredCalled, isTrue);
  });
}
