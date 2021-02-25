import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Faça login na PowerLibrary"),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            await AuthService().signInAnonymously();
          },
          color: Colors.amber,
          child: Text("Entrar!"),
        ),
      ),
    );
  }
}
