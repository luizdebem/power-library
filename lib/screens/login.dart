import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './signup.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _doLogin(Map<String, dynamic> formData) async {
    User user = await AuthService().signInWithEmailAndPassword(
        formData["email"].trim(), formData["password"]);
    if (user == null) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Erro!",
                  style: TextStyle(color: Colors.black87),
                ),
                content: Text(
                  "Não foi possível efetuar o login",
                  style: TextStyle(color: Colors.black87),
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text("OK", style: TextStyle(color: Colors.black87)),
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Faça login na PowerLibrary"),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(SignupScreen.routeName);
            },
            child: Text("Cadastre-se", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: "O email é obrigatóio."),
                      FormBuilderValidators.email(context,
                          errorText: "Email inválido.")
                    ]),
                  ),
                  Divider(),
                  FormBuilderTextField(
                      name: 'password',
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Senha"),
                      keyboardType: TextInputType.text,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: "A senha é obrigatória.")
                      ])),
                  Divider(),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: Colors.green,
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      _formKey.currentState.save();
                      if (_formKey.currentState.validate()) {
                        await _doLogin(_formKey.currentState.value);
                      } else {
                        print("asd");
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
