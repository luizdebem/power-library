import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:power_library/screens/home.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _doSignup(Map<String, dynamic> formData) async {
    User user = await AuthService()
        .signUpWithEmailAndPassword(formData["email"], formData["password"]);
    if (user == null) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Erro!",
                  style: TextStyle(color: Colors.black87),
                ),
                content: Text(
                  "Não foi possível efetuar o cadastro",
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
      return null;
    }
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.settings.name == HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Cadastre-se!"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: "A senha é obrigatória.")
                      ])),
                  Divider(),
                  FormBuilderTextField(
                      name: 'confirmPassword',
                      obscureText: true,
                      decoration:
                          InputDecoration(labelText: "Confirme sua senha"),
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        final senha =
                            _formKey.currentState.fields['password']?.value;
                        if (val != senha) {
                          return "As senhas não coincidem.";
                        }
                        return null;
                      }),
                  Divider()
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
                        await _doSignup(_formKey.currentState.value);
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
