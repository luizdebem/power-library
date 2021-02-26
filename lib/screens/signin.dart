import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../services/auth.dart';
import './signup.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = '/signin';

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Faça login na PowerLibrary"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: "email",
                            decoration: InputDecoration(
                                labelText: "E-mail",
                                border: OutlineInputBorder()),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          Divider(),
                          FormBuilderTextField(
                            obscureText: true,
                            name: "password",
                            decoration: InputDecoration(
                                labelText: "Senha",
                                border: OutlineInputBorder()),
                            keyboardType: TextInputType.text,
                          ),
                          Divider(),
                          FlatButton(
                            onPressed: () async {
                              _formKey.currentState.save();

                              final email =
                                  _formKey.currentState.value['email'];
                              final password =
                                  _formKey.currentState.value['password'];
                              print(email);
                              print(password);
                              await AuthService()
                                  .signInWithEmailAndPassword(email, password);
                              final nav =
                                  Navigator.of(context, rootNavigator: true);
                              nav.pop(); // tirar duvida !!
                            },
                            color: Colors.amber,
                            textColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.amberAccent,
                            child: Text("Entrar!"),
                          ),
                          Divider(
                            height: 50.0,
                          ),
                          Text("Não possui uma conta ainda?"),
                          FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignupScreen.routeName);
                            },
                            color: Colors.white,
                            textColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.amberAccent,
                            child: Text("Crie uma conta."),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
