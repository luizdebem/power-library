import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import './signin.dart';
import 'dart:io' show Platform;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Entre e seja feliz!",
              style: TextStyle(fontSize: 22.0),
            ),
            Divider(),
            SignInButton(
              Buttons.Email,
              elevation: 8.0,
              text: "Entre com seu email",
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                Navigator.pushNamed(context, SigninScreen.routeName);
              },
            ),
            Divider(),
            SignInButton(
              Buttons.Google,
              elevation: 8.0,
              text: "Entre com Google",
              padding: EdgeInsets.all(8.0),
              onPressed: () async {
                await AuthService().signInWithGoogle();
              },
            ),
            Divider(),
            Platform.isIOS
                ? Container(
                    child: Column(
                      children: [
                        SignInButton(
                          Buttons.Apple,
                          elevation: 8.0,
                          text: "Entre com Apple",
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {},
                        ),
                        Divider(),
                      ],
                    ),
                  )
                : Container(),
            Text(
              "ou...",
              style: TextStyle(),
            ),
            Divider(),
            MaterialButton(
              onPressed: () async {
                await AuthService().signInAnonymously();
              },
              color: Colors.amber,
              child: Text("Entre anonimamente!"),
            ),
          ],
        ),
      ),
    );
  }
}
