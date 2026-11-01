import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/constants/app_strings.dart';
import 'package:calley_app/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:calley_app/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:calley_app/features/sign_in/domain/usecases/sign_in_user.dart';
import 'package:calley_app/features/sign_in/presentation/providers/sign_in_provider.dart';

class _SuccessSignInRepo implements SignInRepository {
  SignInRequest? lastRequest;

  @override
  Future<bool> signIn(SignInRequest request) async {
    lastRequest = request;
    return true;
  }

  @override
  Future<void> logout() async {}
}

class _FailureSignInRepo implements SignInRepository {
  @override
  Future<bool> signIn(SignInRequest request) async {
    throw Exception('Sign in failed');
  }

  @override
  Future<void> logout() async {}
}

void main() {
  group('SignInProvider', () {
    test('validation fails when fields are empty or invalid', () {
      final repo = _SuccessSignInRepo();
      final provider = SignInProvider(signInUser: SignInUser(repo));

      expect(provider.validate(), isFalse);
      expect(provider.emailError, AppStrings.errEmailInvalid);
      expect(provider.passwordError, AppStrings.errPasswordShort);
    });

    test('validation succeeds with valid email and password', () {
      final repo = _SuccessSignInRepo();
      final provider = SignInProvider(signInUser: SignInUser(repo));

      provider.setEmail('user@example.com');
      provider.setPassword('securePass123');

      expect(provider.validate(), isTrue);
      expect(provider.emailError, isNull);
      expect(provider.passwordError, isNull);
    });

    test('submit calls repository and triggers onSignedIn callback', () async {
      final repo = _SuccessSignInRepo();
      bool signedInCalled = false;
      final provider = SignInProvider(
        signInUser: SignInUser(repo),
        onSignedIn: () => signedInCalled = true,
      );

      provider.setEmail('user@example.com');
      provider.setPassword('securePass123');

      final ok = await provider.submit();

      expect(ok, isTrue);
      expect(signedInCalled, isTrue);
      expect(repo.lastRequest?.email, 'user@example.com');
      expect(repo.lastRequest?.password, 'securePass123');
    });

    test('failed submit sets general error', () async {
      final repo = _FailureSignInRepo();
      final provider = SignInProvider(signInUser: SignInUser(repo));

      provider.setEmail('user@example.com');
      provider.setPassword('securePass123');

      final ok = await provider.submit();

      expect(ok, isFalse);
      expect(provider.generalError, AppStrings.errGeneric);
    });
  });
}
