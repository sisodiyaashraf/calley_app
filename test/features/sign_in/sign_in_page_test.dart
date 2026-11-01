import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/auth_link_text.dart';
import 'package:calley_app/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:calley_app/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:calley_app/features/sign_in/domain/usecases/sign_in_user.dart';
import 'package:calley_app/features/sign_in/presentation/pages/sign_in_page.dart';
import 'package:calley_app/features/sign_in/presentation/providers/sign_in_provider.dart';

class _FakeSignInRepo implements SignInRepository {
  @override
  Future<bool> signIn(SignInRequest request) async => true;
  @override
  Future<void> logout() async {}
}

Widget createTestableSignInWidget({
  required SignInProvider provider,
  VoidCallback? onSignedIn,
  VoidCallback? onForgotPasswordTapped,
  VoidCallback? onSignUpTapped,
}) {
  return ChangeNotifierProvider<SignInProvider>.value(
    value: provider,
    child: MaterialApp(
      theme: AppTheme.light,
      home: SignInPage(
        onSignedIn: onSignedIn,
        onForgotPasswordTapped: onForgotPasswordTapped,
        onSignUpTapped: onSignUpTapped,
      ),
    ),
  );
}

void main() {
  testWidgets('renders all Sign In page elements without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final provider = SignInProvider(
      signInUser: SignInUser(_FakeSignInRepo()),
    );

    await tester.pumpWidget(createTestableSignInWidget(provider: provider));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.welcomeSignIn), findsOneWidget);
    expect(find.text(AppStrings.signInSubtitle), findsOneWidget);
    expect(find.text(AppStrings.hintEmail), findsOneWidget);
    expect(find.text(AppStrings.hintPassword), findsOneWidget);
    expect(find.text(AppStrings.forgotPassword), findsOneWidget);
    expect(find.byType(AuthLinkText), findsOneWidget);
    expect(find.text(AppStrings.signInButton), findsOneWidget);
  });

  testWidgets('submitting empty form displays error messages', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final provider = SignInProvider(
      signInUser: SignInUser(_FakeSignInRepo()),
    );

    await tester.pumpWidget(createTestableSignInWidget(provider: provider));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.signInButton));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.errEmailInvalid), findsOneWidget);
    expect(find.text(AppStrings.errPasswordShort), findsOneWidget);
  });

  testWidgets('tapping Forgot Password triggers callback', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    bool forgotTapped = false;
    final provider = SignInProvider(
      signInUser: SignInUser(_FakeSignInRepo()),
    );

    await tester.pumpWidget(createTestableSignInWidget(
      provider: provider,
      onForgotPasswordTapped: () => forgotTapped = true,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.forgotPassword));
    await tester.pumpAndSettle();

    expect(forgotTapped, isTrue);
  });

  testWidgets('tapping Sign Up link triggers onSignUpTapped', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    bool signUpTapped = false;
    final provider = SignInProvider(
      signInUser: SignInUser(_FakeSignInRepo()),
    );

    await tester.pumpWidget(createTestableSignInWidget(
      provider: provider,
      onSignUpTapped: () => signUpTapped = true,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(AuthLinkText));
    await tester.pumpAndSettle();

    expect(signUpTapped, isTrue);
  });

  testWidgets('valid form submission triggers onSignedIn', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    bool signedInCalled = false;
    final provider = SignInProvider(
      signInUser: SignInUser(_FakeSignInRepo()),
      onSignedIn: () => signedInCalled = true,
    );

    await tester.pumpWidget(createTestableSignInWidget(
      provider: provider,
      onSignedIn: () => signedInCalled = true,
    ));
    await tester.pumpAndSettle();

    provider.setEmail('user@example.com');
    provider.setPassword('secretPassword123');
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.signInButton));
    await tester.pumpAndSettle();

    expect(signedInCalled, isTrue);
  });
}
