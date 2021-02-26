import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  signInWithEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw (e);
    }
  }

  signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      throw (e);
    }
  }

  signUpWithEmailAndPassword(email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw (e);
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
