import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../services/auth.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Crie sua conta"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    FormBuilder(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: "Campo obrigatório."),
                                FormBuilderValidators.email(context,
                                    errorText: "Deve ser um e-mail válido.")
                              ]),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              name: "email",
                              decoration: InputDecoration(
                                  labelText: "E-mail",
                                  border: OutlineInputBorder()),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            Divider(),
                            FormBuilderTextField(
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: "Campo obrigatório."),
                                FormBuilderValidators.minLength(context, 8,
                                    errorText: "Mínimo 8 caracteres."),
                                FormBuilderValidators.match(context,
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                    errorText:
                                        "Deve conter números, caracteres especiais e maiúsculos.")
                              ]),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                if (_formKey.currentState.validate()) {
                                  final email =
                                      _formKey.currentState.value['email'];
                                  final password =
                                      _formKey.currentState.value['password'];
                                  print(email);
                                  print(password);
                                  await AuthService()
                                      .signUpWithEmailAndPassword(
                                          email, password);
                                  Navigator.of(context).popUntil((route) {
                                    return route.settings.name == "/";
                                  });
                                } else {
                                  return;
                                }
                              },
                              color: Colors.amber,
                              textColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.amberAccent,
                              child: Text("Registrar!"),
                            ),
                            Divider(
                              height: 50.0,
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
      ),
    );
  }
}
