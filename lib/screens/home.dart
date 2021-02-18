import 'package:flutter/material.dart';
import 'package:power_library/models/book.dart';
import 'package:power_library/screens/form.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> _myBooks = [
    Book(author: "Josias", title: "Universo em Desencanto", isRead: true),
    Book(
        author: "Josias",
        title: "Universo em Desencanto parte 2",
        isRead: true),
    Book(author: "Manolo", title: "Java para Iniciantes", isRead: false),
    Book(
        author: "Manolo",
        title: "Estrutura de Dados para Iniciantes",
        isRead: true),
    Book(author: "Manolo", title: "Arquitetura de Software", isRead: false)
  ];

  int readBooksCount() {
    return _myBooks.where((book) => book.isRead).length;
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Power Library")),
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment
          //     .center, // essa linha diz: alinha o main axis (y) pro centro em relação ao teu elemento-pai.
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                "assets/images/logowide.png",
                width: 240.0,
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _myBooks.length,
                itemBuilder: (ctx, index) => ListTile(
                  title: Text(_myBooks[index].title),
                  subtitle: Text(_myBooks[index].author),
                  leading: Icon(Icons.book),
                  trailing: _myBooks[index].isRead
                      ? Icon(Icons.check_box_outlined)
                      : Icon(Icons.check_box_outline_blank),
                ),
                separatorBuilder: (context, index) => Divider(),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(
                    20.0, isIOS ? 20.0 : 10.0, 20.0, isIOS ? 22.0 : 10.0),
                decoration: BoxDecoration(color: Colors.teal),
                child: Text(
                    "Livros Lidos: ${readBooksCount()}/${_myBooks.length}",
                    style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, BookForm.routeName)},
        tooltip: "Adicionar Livro",
        child: Icon(Icons.add),
      ),
    );
  }
}
