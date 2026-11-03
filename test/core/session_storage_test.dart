import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calley_app/core/session/session_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('SessionStorage saves, loads and clears user session state', () async {
    final initial = await SessionStorage.load();
    expect(initial.isLoggedIn, isFalse);
    expect(initial.name, isEmpty);

    await SessionStorage.save('Test User', 'test@example.com');
    final saved = await SessionStorage.load();
    expect(saved.isLoggedIn, isTrue);
    expect(saved.name, 'Test User');
    expect(saved.email, 'test@example.com');

    await SessionStorage.clear();
    final cleared = await SessionStorage.load();
    expect(cleared.isLoggedIn, isFalse);
    expect(cleared.name, isEmpty);
    expect(cleared.email, isEmpty);
  });
}
