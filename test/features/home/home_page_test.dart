import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/primary_button.dart';
import 'package:calley_app/core/widgets/profile_header_card.dart';
import 'package:calley_app/core/widgets/whatsapp_action_button.dart';
import 'package:calley_app/features/app_drawer/presentation/widgets/app_drawer.dart';
import 'package:calley_app/features/home/domain/entities/user_profile.dart';
import 'package:calley_app/features/home/domain/repositories/home_repository.dart';
import 'package:calley_app/features/home/domain/usecases/get_user_profile.dart';
import 'package:calley_app/features/home/presentation/pages/home_page.dart';
import 'package:calley_app/features/home/presentation/providers/home_provider.dart';
import 'package:calley_app/features/home/presentation/widgets/first_time_info_card.dart';
import 'package:calley_app/features/home/presentation/widgets/video_thumbnail.dart';

class _FakeHomeRepo implements HomeRepository {
  @override
  Future<UserProfile> getProfile() async =>
      const UserProfile(name: 'Swati', title: 'Calley Personal');
}

Widget createTestableHomeWidget({
  required HomeProvider provider,
  VoidCallback? onVideoTapped,
  VoidCallback? onWhatsAppTapped,
  VoidCallback? onStartCallingTapped,
}) {
  return ChangeNotifierProvider<HomeProvider>.value(
    value: provider,
    child: MaterialApp(
      theme: AppTheme.light,
      home: HomePage(
        onVideoTapped: onVideoTapped,
        onWhatsAppTapped: onWhatsAppTapped,
        onStartCallingTapped: onStartCallingTapped,
      ),
    ),
  );
}

void main() {
  testWidgets('renders all Home page elements on 366x721 design frame',
      (tester) async {
    tester.view.physicalSize = const Size(366, 721);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final provider = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));

    await tester.pumpWidget(createTestableHomeWidget(provider: provider));
    await tester.pumpAndSettle();

    expect(find.byType(ProfileHeaderCard), findsOneWidget);
    expect(find.text('${AppStrings.helloPrefix}Swati'), findsOneWidget);
    expect(find.text('Calley Personal'), findsOneWidget);

    expect(find.byType(FirstTimeInfoCard), findsOneWidget);
    expect(find.text(AppStrings.homeInfoNotice), findsOneWidget);
    expect(find.byType(VideoThumbnail), findsOneWidget);

    expect(find.byType(WhatsAppActionButton), findsOneWidget);
    expect(find.text(AppStrings.startCallingNow), findsOneWidget);
  });

  testWidgets('tapping actions triggers callbacks', (tester) async {
    tester.view.physicalSize = const Size(366, 721);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    bool videoTapped = false;
    bool whatsappTapped = false;
    bool callingTapped = false;

    final provider = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));

    await tester.pumpWidget(createTestableHomeWidget(
      provider: provider,
      onVideoTapped: () => videoTapped = true,
      onWhatsAppTapped: () => whatsappTapped = true,
      onStartCallingTapped: () => callingTapped = true,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(VideoThumbnail));
    await tester.pumpAndSettle();
    expect(videoTapped, isTrue);

    await tester.tap(find.byType(WhatsAppActionButton));
    await tester.pumpAndSettle();
    expect(whatsappTapped, isTrue);

    await tester.tap(find.byType(PrimaryButton));
    await tester.pumpAndSettle();
    expect(callingTapped, isTrue);
  });

  testWidgets('zero overflow errors on compact heights', (tester) async {
    tester.view.physicalSize = const Size(320, 500);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final provider = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));

    await tester.pumpWidget(createTestableHomeWidget(provider: provider));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(ProfileHeaderCard), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
  });

  testWidgets('home app bar icons are positioned safely below status bar notch', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    tester.view.padding = const FakeViewPadding(top: 44, bottom: 34);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPadding);

    final provider = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));

    await tester.pumpWidget(createTestableHomeWidget(provider: provider));
    await tester.pumpAndSettle();

    final menuIcon = tester.getTopLeft(find.byIcon(Icons.menu));
    expect(menuIcon.dy, greaterThanOrEqualTo(44.0));
  });

  testWidgets('tapping menu icon opens drawer without Scaffold.of exception', (tester) async {
    final provider = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));

    await tester.pumpWidget(createTestableHomeWidget(provider: provider));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(AppDrawer), findsOneWidget);
  });
}
