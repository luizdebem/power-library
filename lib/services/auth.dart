import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User> get user {
    return auth.authStateChanges();
  }

  Future<void> signOut() async {
    try {
      return auth.signOut();
    } catch (e) {
      print("Error firebase sign out: ${e.toString()}");
      return null;
    }
  }

  Future<User> signInAnonymously() async {
    try {
      UserCredential userCredential = await auth
          .signInAnonymously(); // é legal mexer depois nas regras de read/write no firebase
      return userCredential.user;
    } catch (e) {
      print("Error firebase anon auth: ${e.toString()}");
      return null;
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print("Erro sign in email/password" + e.toString());
      return null;
    }
  }

  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print("Erro sign up email/password" + e.toString());
      return null;
    }
  }
}
