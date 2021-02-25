import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User> get user {
    return auth.authStateChanges();
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

  Future<void> signOut() async {
    try {
      return auth.signOut();
    } catch (e) {
      print("Error firebase sign out: ${e.toString()}");
    }
  }
}
