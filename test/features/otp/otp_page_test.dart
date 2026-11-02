import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/navigation/app_router.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/auth_link_text.dart';
import 'package:calley_app/core/widgets/primary_button.dart';
import 'package:calley_app/features/otp/domain/entities/otp_verification.dart';
import 'package:calley_app/features/otp/domain/repositories/otp_repository.dart';
import 'package:calley_app/features/otp/domain/usecases/resend_otp.dart';
import 'package:calley_app/features/otp/domain/usecases/verify_otp.dart';
import 'package:calley_app/features/otp/presentation/pages/otp_page.dart';
import 'package:calley_app/features/otp/presentation/providers/otp_provider.dart';

class _FakeOtpRepo implements OtpRepository {
  @override
  Future<bool> verify(OtpVerification verification) async =>
      verification.code == '123456';

  @override
  Future<bool> resend(String phone) async => true;
}

Widget createTestableOtpWidget({
  required OtpProvider provider,
  String phone = '+91 9876543210',
  VoidCallback? onVerified,
}) {
  return ChangeNotifierProvider<OtpProvider>.value(
    value: provider,
    child: MaterialApp(
      theme: AppTheme.light,
      home: OtpPage(
        phoneNumber: phone,
        onVerified: onVerified,
      ),
    ),
  );
}

void main() {
  testWidgets('renders all OTP page elements without overflow', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repo = _FakeOtpRepo();
    final provider = OtpProvider(
      verifyOtp: VerifyOtp(repo),
      resendOtp: ResendOtp(repo),
    );

    await tester.pumpWidget(createTestableOtpWidget(provider: provider));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.otpTitle), findsOneWidget);
    expect(find.text(AppStrings.otpDescription), findsOneWidget);
    expect(find.text('+91 9876543210'), findsOneWidget);
    expect(find.byType(AuthLinkText), findsOneWidget);
    expect(find.text(AppStrings.verify), findsOneWidget);

    final button = tester.widget<PrimaryButton>(find.byType(PrimaryButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('filling 6 digits enables Verify and tapping triggers onVerified',
      (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repo = _FakeOtpRepo();
    bool verifiedCalled = false;
    final provider = OtpProvider(
      verifyOtp: VerifyOtp(repo),
      resendOtp: ResendOtp(repo),
      onVerified: () => verifiedCalled = true,
    );

    await tester.pumpWidget(createTestableOtpWidget(
      provider: provider,
      onVerified: () => verifiedCalled = true,
    ));
    await tester.pumpAndSettle();

    provider.setCode('123456');
    await tester.pumpAndSettle();

    final button = tester.widget<PrimaryButton>(find.byType(PrimaryButton));
    expect(button.onPressed, isNotNull);

    await tester.tap(find.text(AppStrings.verify));
    await tester.pumpAndSettle();

    expect(verifiedCalled, isTrue);
  });

  testWidgets('failed verification shows red error text', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repo = _FakeOtpRepo();
    final provider = OtpProvider(
      verifyOtp: VerifyOtp(repo),
      resendOtp: ResendOtp(repo),
    );

    await tester.pumpWidget(createTestableOtpWidget(provider: provider));
    await tester.pumpAndSettle();

    provider.setCode('000000');
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.verify));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.errInvalidOtp), findsOneWidget);
  });

  testWidgets('tapping Resend OTP starts countdown timer', (tester) async {
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repo = _FakeOtpRepo();
    final provider = OtpProvider(
      verifyOtp: VerifyOtp(repo),
      resendOtp: ResendOtp(repo),
    );

    await tester.pumpWidget(createTestableOtpWidget(provider: provider));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(AuthLinkText));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(provider.canResend, isFalse);
    expect(provider.resendCountdown, lessThanOrEqualTo(30));

    provider.dispose();
  });

  testWidgets('verification with default callback pushes home route', (tester) async {
    final repo = _FakeOtpRepo();
    final provider = OtpProvider(
      verifyOtp: VerifyOtp(repo),
      resendOtp: ResendOtp(repo),
    );
    String? pushedRoute;
    await tester.pumpWidget(
      ChangeNotifierProvider<OtpProvider>.value(
        value: provider,
        child: MaterialApp(
          theme: AppTheme.light,
          onGenerateRoute: (settings) {
            pushedRoute = settings.name;
            return MaterialPageRoute(builder: (_) => const Scaffold(), settings: settings);
          },
          home: const OtpPage(phoneNumber: '+91 9876543210'),
        ),
      ),
    );
    provider.setCode('123456');
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.verify));
    await tester.pumpAndSettle();
    expect(pushedRoute, AppRoutes.home);
  });
}
