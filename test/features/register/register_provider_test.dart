import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/features/register/domain/entities/register_request.dart';
import 'package:calley_app/features/register/domain/repositories/register_repository.dart';
import 'package:calley_app/features/register/domain/usecases/register_user.dart';
import 'package:calley_app/features/register/presentation/providers/register_provider.dart';

class _SuccessRepo implements RegisterRepository {
  RegisterRequest? lastRequest;

  @override
  Future<bool> register(RegisterRequest request) async {
    lastRequest = request;
    return true;
  }
}

class _FailureRepo implements RegisterRepository {
  @override
  Future<bool> register(RegisterRequest request) async {
    throw Exception('Server error');
  }
}

void main() {
  group('RegisterProvider', () {
    test('validation fails when fields are empty', () {
      final repo = _SuccessRepo();
      final provider = RegisterProvider(registerUser: RegisterUser(repo));

      expect(provider.validate(), isFalse);
      expect(provider.nameError, AppStrings.errNameRequired);
      expect(provider.emailError, AppStrings.errEmailInvalid);
      expect(provider.passwordError, AppStrings.errPasswordShort);
      expect(provider.phoneError, AppStrings.errPhoneInvalid);
      expect(provider.termsError, AppStrings.errTermsRequired);
    });

    test('toggleTerms toggles state and clears termsError', () {
      final repo = _SuccessRepo();
      final provider = RegisterProvider(registerUser: RegisterUser(repo));

      expect(provider.agreedToTerms, isFalse);
      provider.validate();
      expect(provider.termsError, isNotNull);

      provider.toggleTerms();
      expect(provider.agreedToTerms, isTrue);
      expect(provider.termsError, isNull);
    });

    test('successful submit calls use case and onRegistered callback', () async {
      final repo = _SuccessRepo();
      bool registeredCalled = false;
      final provider = RegisterProvider(
        registerUser: RegisterUser(repo),
        onRegistered: () => registeredCalled = true,
      );

      provider.setName('John Doe');
      provider.setEmail('john@example.com');
      provider.setPassword('secret123');
      provider.setPhone('9876543210');
      provider.toggleTerms();

      final result = await provider.submit();

      expect(result, isTrue);
      expect(registeredCalled, isTrue);
      expect(repo.lastRequest?.name, 'John Doe');
      expect(repo.lastRequest?.email, 'john@example.com');
      expect(repo.lastRequest?.phone, '9876543210');
      expect(repo.lastRequest?.countryCode, '+91');
    });

    test('failed submit sets generalError', () async {
      final repo = _FailureRepo();
      final provider = RegisterProvider(registerUser: RegisterUser(repo));

      provider.setName('John Doe');
      provider.setEmail('john@example.com');
      provider.setPassword('secret123');
      provider.setPhone('9876543210');
      provider.toggleTerms();

      final result = await provider.submit();

      expect(result, isFalse);
      expect(provider.generalError, AppStrings.errGeneric);
    });
  });
}
