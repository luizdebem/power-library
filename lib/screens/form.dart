import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:power_library/services/database.dart';

class BookForm extends StatefulWidget {
  static const routeName = '/form';

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isRead = false;
  var book;

  void toggleSwitch(_) {
    setState(() {
      isRead = _formKey.currentState.fields['isRead'].value;
      print(isRead);

      if (!isRead) {
        _formKey.currentState.fields['rate']?.didChange(0.0);
      }
    });
  }

  void _saveBook(Map<String, dynamic> bookData) async {
    String coverPath;

    if (bookData['cover'].length > 0) {
      coverPath = await DatabaseService().uploadFile(bookData['cover'][0]);
    }

    coverPath ??= book?.cover;

    final newBookData = {...bookData, 'cover': coverPath};

    if (book?.id == null) {
      await DatabaseService().addBook(newBookData);
    } else {
      await DatabaseService().updateBook(book.id, newBookData);
    }
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void didChangeDependencies() {
    book = ModalRoute.of(context)
        .settings
        .arguments; // Pegando os parâmetros passados pelo Navigator
    isRead = book?.isRead ?? false;
    print(isRead);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Novo Livro"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Container(
          child: Column(
            children: [
              FormBuilder(
                key: _formKey,
                initialValue: book
                    ?.toJson(), // Se tiver book, vamos parsear e usar no Form
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
                    FormBuilderImagePicker(
                      name: "cover",
                      maxImages: 1,
                      initialValue: [],
                      cameraLabel: Text(
                        "Tire uma foto da capa do livro!",
                        style: TextStyle(color: Colors.black87),
                      ),
                      galleryLabel: Text(
                        "Escolha uma imagem da sua galeria!",
                        style: TextStyle(color: Colors.black87),
                      ),
                      decoration: InputDecoration(
                          labelText: "Capa",
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                      placeholderImage: book?.url != null
                          ? Image.network(book.url).image
                          : Image.asset(
                              "assets/images/cameraplaceholder.jpg",
                              width: 60.0,
                              height: 80.0,
                            ).image,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FormBuilderSwitch(
                      name: "isRead",
                      initialValue: book?.isRead ?? false,
                      title: Text("Leitura finalizada?"),
                      onChanged: toggleSwitch,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    isRead
                        ? FormBuilderRating(
                            name: 'rate',
                            initialValue: book?.rate?.toDouble() ?? 0.0,
                            max: 5.0,
                            enabled: isRead,
                            filledColor: Colors.amber,
                            validator: (val) {
                              if (!isRead) {
                                return null;
                              }
                              if (val == null || val < 1.0) {
                                return "Dê uma avaliação entre 1 e 5 estrelas.";
                              }
                              return null;
                            })
                        : Container()
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                child: Text("Salvar"),
                onPressed: () async {
                  _formKey.currentState
                      .save(); // evitar que o usuário perca o progesso do formulário
                  if (_formKey.currentState.validate()) {
                    print("Success book form:");
                    print(_formKey.currentState.value);

                    _saveBook(_formKey.currentState.value);
                  } else {
                    print("Error book form:");
                    print(_formKey.currentState.value);

                    await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(
                                "Erro!",
                                style: TextStyle(color: Colors.black87),
                              ),
                              content: Text(
                                "Não foi possível salvar o livro, dados inválidos.",
                                style: TextStyle(color: Colors.black87),
                              ),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ],
                            ));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
