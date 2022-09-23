import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import '../../../utils/delay.dart';
import 'auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.addDelay = true});
  final _authState = InMemoryStore<AppUser?>(null);
  final bool addDelay;

  @override
  AppUser? get currentUser => _authState.value;

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);
    if (currentUser == null) {
      _authState.value = AppUser(
        uid: email.split('').reversed.join(),
        email: email,
      );
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await delay(addDelay);
    if (currentUser == null) {
      _authState.value = AppUser(
        uid: email.split('').reversed.join(),
        email: email,
      );
    }
  }

  @override
  Future<void> signOut() async {
    await delay(addDelay);
    _authState.value = null;
  }

  void dispose() => _authState.close();
}
