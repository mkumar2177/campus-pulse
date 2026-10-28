import 'package:campus_pulse/data/local_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('rejects duplicate event registrations', () async {
    final repository = LocalRepository();
    await repository.initialize();
    await repository.register('hack-night');
    expect(() => repository.register('hack-night'), throwsStateError);
  });

  test('creates a validated local student account', () async {
    final repository = LocalRepository();
    await repository.initialize();
    await repository.signUp(
      name: 'New Student',
      email: 'new.student@example.edu',
      password: 'secure-pass',
    );
    expect(repository.isAuthenticated, isTrue);
    expect(repository.currentUser.name, 'New Student');
  });
}
