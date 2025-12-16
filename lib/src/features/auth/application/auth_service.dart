import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:myapp/src/features/auth/domain/app_user.dart';
import 'package:myapp/src/features/auth/infrastructure/firebase_auth_repository.dart';

class AuthService {
  final FirebaseAuthRepository _authRepository;

  AuthService(this._authRepository);

  Stream<AppUser?> get authStateChanges => _authRepository.authStateChanges;

  Future<void> signInWithEmailAndPassword(String email, String password) {
    return _authRepository.signInWithEmailAndPassword(email, password);
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) {
    return _authRepository.createUserWithEmailAndPassword(email, password);
  }

  Future<void> signOut() {
    return _authRepository.signOut();
  }

  AppUser? get currentUser => _authRepository.currentUser;
}
