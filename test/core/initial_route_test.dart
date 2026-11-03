import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/navigation/app_router.dart';
import 'package:calley_app/core/navigation/initial_route.dart';

void main() {
  test('resolveInitialRoute maps login status to correct route', () {
    expect(resolveInitialRoute(true), AppRoutes.home);
    expect(resolveInitialRoute(false), AppRoutes.language);
  });
}
