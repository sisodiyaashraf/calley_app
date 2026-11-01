import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/theme/app_theme.dart';
import 'package:calley_app/core/widgets/arrow_box_button.dart';
import 'package:calley_app/core/widgets/icon_box.dart';
import 'package:calley_app/core/widgets/section_card.dart';
import 'package:calley_app/features/home/domain/entities/user_profile.dart';
import 'package:calley_app/features/home/domain/repositories/home_repository.dart';
import 'package:calley_app/features/home/domain/usecases/get_user_profile.dart';
import 'package:calley_app/features/home/presentation/providers/home_provider.dart';
import 'package:calley_app/features/settings/presentation/pages/settings_page.dart';
import 'package:calley_app/features/settings/presentation/widgets/profile_summary_card.dart';
import 'package:calley_app/features/settings/presentation/widgets/settings_row.dart';

class _FakeHomeRepo implements HomeRepository {
  @override
  Future<UserProfile> getProfile() async => const UserProfile(
        name: 'Swati',
        title: 'Calley Personal',
        email: 'swati@cstech.in',
        phone: '9971125588',
        parentAccount: 'NA',
        subscription: 'Calley Personal',
      );
}

Widget _wrapSettings({
  VoidCallback? onLang,
  VoidCallback? onPass,
  VoidCallback? onLists,
}) {
  final homeP = HomeProvider(getUserProfile: GetUserProfile(_FakeHomeRepo()));
  return ChangeNotifierProvider<HomeProvider>.value(
    value: homeP,
    child: MaterialApp(
      theme: AppTheme.light,
      home: SettingsPage(
        onAppLanguageTapped: onLang,
        onChangePasswordTapped: onPass,
        onCallingListsTapped: onLists,
      ),
    ),
  );
}

void main() {
  testWidgets('renders all SettingsPage elements on 376 wide frame', (tester) async {
    tester.view.physicalSize = const Size(376, 750);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_wrapSettings());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    expect(find.text(AppStrings.settingsTitle), findsOneWidget);

    expect(find.byType(ProfileSummaryCard), findsOneWidget);
    expect(find.text('${AppStrings.helloPrefix}Swati'), findsOneWidget);
    expect(find.text('swati@cstech.in'), findsOneWidget);
    expect(find.text('9971125588'), findsOneWidget);
    expect(find.text('${AppStrings.parentAccountPrefix}NA'), findsOneWidget);
    expect(find.text('${AppStrings.subscriptionPrefix}Calley Personal'), findsOneWidget);

    expect(find.byType(SectionCard), findsOneWidget);
    expect(find.text(AppStrings.profileSettingsBand), findsOneWidget);

    expect(find.byType(SettingsRow), findsNWidgets(3));
    expect(find.text(AppStrings.appLanguage), findsOneWidget);
    expect(find.text(AppStrings.changePassword), findsOneWidget);
    expect(find.text(AppStrings.callingLists), findsOneWidget);

    expect(find.byType(IconBox), findsNWidgets(3));
    expect(find.byType(ArrowBoxButton), findsNWidgets(3));
  });

  testWidgets('tapping settings rows fires corresponding callbacks', (tester) async {
    bool lang = false, pass = false, lists = false;

    await tester.pumpWidget(_wrapSettings(
      onLang: () => lang = true,
      onPass: () => pass = true,
      onLists: () => lists = true,
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.appLanguage));
    expect(lang, isTrue);

    await tester.tap(find.text(AppStrings.changePassword));
    expect(pass, isTrue);

    await tester.tap(find.text(AppStrings.callingLists));
    expect(lists, isTrue);
  });

  testWidgets('scrolls gracefully on compact height without overflow', (tester) async {
    tester.view.physicalSize = const Size(320, 400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_wrapSettings());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(ProfileSummaryCard), findsOneWidget);
  });
}
