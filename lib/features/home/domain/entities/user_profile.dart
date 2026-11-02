/// Domain entity representing the logged-in user profile.
class UserProfile {
  const UserProfile({
    required this.name,
    required this.title,
    this.email = '',
    this.phone = '',
    this.parentAccount = 'NA',
    this.subscription = 'Calley Personal',
  });

  final String name;
  final String title;
  final String email;
  final String phone;
  final String parentAccount;
  final String subscription;
}
