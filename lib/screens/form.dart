import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BookForm extends StatefulWidget {
  static const routeName = '/form';

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isRead = false;

  void toggleSwitch(_) {
    setState(() {
      isRead = _formKey.currentState.fields['isRead'].value;

      if (!isRead) {
        _formKey.currentState.fields['rate']?.didChange(0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo Livro")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Container(
          child: Column(
            children: [
              FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: "O nome do livro é obrigatório."),
                        FormBuilderValidators.minLength(context, 3,
                            errorText:
                                "O nome do livro precisa ter pelo menos 3 caracteres.")
                      ]),
                      name: "title",
                      decoration: InputDecoration(
                          labelText: "Título do Livro",
                          hintText: "Título",
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FormBuilderTextField(
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: "O nome do autor é obrigatório."),
                        FormBuilderValidators.minLength(context, 3,
                            errorText:
                                "O nome do autor precisa ter pelo menos 3 caracteres.")
                      ]),
                      name: "author",
                      decoration: InputDecoration(
                          labelText: "Nome do Autor",
                          hintText: "Nome",
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FormBuilderSwitch(
                      name: "isRead",
                      initialValue: false,
                      title: Text("Leitura finalizada?"),
                      onChanged: toggleSwitch,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    isRead
                        ? FormBuilderRating(
                            name: 'rate',
                            initialValue: 0.0,
                            max: 5.0,
                            enabled: isRead,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.min(context, 1.0,
                                  errorText:
                                      "Deixe uma avaliação para o livro!")
                            ]))
                        : Container()
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                child: Text("Salvar"),
                onPressed: () {
                  _formKey.currentState.validate();
                  print(_formKey.currentState.value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
