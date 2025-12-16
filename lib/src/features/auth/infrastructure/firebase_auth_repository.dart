import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:myapp/src/features/auth/domain/app_user.dart';
import 'package:myapp/src/features/auth/domain/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  @override
  Stream<AppUser?> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((firebaseUser) {
        if (firebaseUser == null) {
          return null;
        }
        return AppUser(uid: firebaseUser.uid, email: firebaseUser.email);
      });

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  AppUser? get currentUser {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email);
  }
}
