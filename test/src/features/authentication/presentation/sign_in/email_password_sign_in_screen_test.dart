import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  const testEmail = 'test@test.com';
  const testPassword = '1234';
  late MockAuthRepository authRepository;
  setUp(() => authRepository = MockAuthRepository());
  group('sign in', () {
    testWidgets('''
    Given formType is signIn
    When tap on the sign-in button
    Then signInWithEmailAndPassword is not called
    ''', (tester) async {
      final r = AuthRobot(tester);
    });
  });
}
