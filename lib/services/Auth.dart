import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;

class Auth {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  User? get currentUser => _fireBaseAuth.currentUser;
  Stream<User?> get authStateChanges => _fireBaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _fireBaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _fireBaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _fireBaseAuth.signOut();
  }
}
