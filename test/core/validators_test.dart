import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/core/utils/validators.dart';

void main() {
  group('Validators', () {
    test('name validator', () {
      expect(Validators.name(null), AppStrings.errNameRequired);
      expect(Validators.name(''), AppStrings.errNameRequired);
      expect(Validators.name('a'), AppStrings.errNameRequired);
      expect(Validators.name('  a  '), AppStrings.errNameRequired);
      expect(Validators.name('Al'), isNull);
      expect(Validators.name('John Doe'), isNull);
    });

    test('email validator', () {
      expect(Validators.email(null), AppStrings.errEmailInvalid);
      expect(Validators.email(''), AppStrings.errEmailInvalid);
      expect(Validators.email('invalid'), AppStrings.errEmailInvalid);
      expect(Validators.email('test@'), AppStrings.errEmailInvalid);
      expect(Validators.email('test@domain'), AppStrings.errEmailInvalid);
      expect(Validators.email('test@domain.com'), isNull);
      expect(Validators.email('user.name+tag@sub.domain.co'), isNull);
    });

    test('password validator', () {
      expect(Validators.password(null), AppStrings.errPasswordShort);
      expect(Validators.password(''), AppStrings.errPasswordShort);
      expect(Validators.password('1234567'), AppStrings.errPasswordShort);
      expect(Validators.password('12345678'), isNull);
      expect(Validators.password('supersecurepass'), isNull);
    });

    test('phone validator', () {
      expect(Validators.phone(null), AppStrings.errPhoneInvalid);
      expect(Validators.phone(''), AppStrings.errPhoneInvalid);
      expect(Validators.phone('12345'), AppStrings.errPhoneInvalid);
      expect(Validators.phone('12345678901'), AppStrings.errPhoneInvalid);
      expect(Validators.phone('abcdefghij'), AppStrings.errPhoneInvalid);
      expect(Validators.phone('9876543210'), isNull);
    });
  });
}
