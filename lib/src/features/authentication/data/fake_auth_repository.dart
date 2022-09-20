import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> authStateChanges() => Stream.value(null);

  @override
  AppUser? get currentUser => null; //todo to be finished

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    //todo implement
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    //todo implement
  }

  @override
  Future<void> signOut() async {
    //todo implement
  }
}
