import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  group('AccountScreenController', () {
    test('Initial state is Async.data', () {
      final authRepository = FakeAuthRepository();
      final controller =
          AccountScreenController(authRepository: authRepository);
      expect(controller.debugState, const AsyncData<void>(null));
    });

    test('signOut success', () async {
      // setup
      final authRepository = MockAuthRepository();
      when(authRepository.signOut).thenAnswer((_) => Future.value());
      final controller =
          AccountScreenController(authRepository: authRepository);
      // run
      await controller.signOut();
      // verify
      expect(controller.debugState, const AsyncData<void>(null));
      verify(authRepository.signOut).called(1);
    });

    test('signOut failure', () async {
      // setup
      final authRepository = MockAuthRepository();
      final exception = Exception('Conntection failed');
      when(authRepository.signOut).thenThrow(exception);
      final controller =
          AccountScreenController(authRepository: authRepository);
      // run
      await controller.signOut();
      // verify
      verify(authRepository.signOut).called(1);
      expect(controller.debugState.hasError, true);
    });
  });
}
