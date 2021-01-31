import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthorizationServiceProtocol {
  Future<UserCredential> login(String email, String password);

  Future<UserCredential> signUp(String email, String password);
}

class AuthorizationService implements AuthorizationServiceProtocol {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<UserCredential> signUp(String email, String password) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}
