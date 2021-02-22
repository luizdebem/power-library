import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> signInAnonymously() async {
    try {
      UserCredential userCredential = await auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print("Error firebase anon auth: ${e.toString()}");
      return null;
    }
  }
}
