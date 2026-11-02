/// In-memory user session holding authentication tokens and user credentials.
/// NOTE: Hardcoded default credentials will be replaced by the real
/// sign-in response once the login endpoint is integrated.
class Session {
  Session({
    this.userId = '68626f9497757cb741f449b0',
    this.email = 'dhrubo@yopmail.com',
  });

  String userId;
  String email;

  void update({required String newUserId, required String newEmail}) {
    userId = newUserId;
    email = newEmail;
  }
}
