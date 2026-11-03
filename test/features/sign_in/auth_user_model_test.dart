import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/features/sign_in/data/models/auth_user_model.dart';

void main() {
  group('AuthUserModel.fromJson', () {
    test('parses full login response correctly', () {
      final json = {
        '_id': 'user_12345',
        'username': 'john_doe',
        'email': 'john@example.com',
      };
      final model = AuthUserModel.fromJson(json);

      expect(model.id, 'user_12345');
      expect(model.username, 'john_doe');
      expect(model.email, 'john@example.com');
    });

    test('parses json with id field fallback', () {
      final json = {
        'id': 'alt_user_id',
        'username': 'jane_doe',
        'email': 'jane@example.com',
      };
      final model = AuthUserModel.fromJson(json);

      expect(model.id, 'alt_user_id');
      expect(model.username, 'jane_doe');
      expect(model.email, 'jane@example.com');
    });

    test('toJson returns corresponding map structure', () {
      const model = AuthUserModel(id: 'u1', username: 'alex', email: 'alex@a.com');
      final map = model.toJson();
      expect(map['_id'], 'u1');
      expect(map['username'], 'alex');
      expect(map['email'], 'alex@a.com');
    });
  });
}
