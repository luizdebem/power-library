import 'package:flutter/material.dart';
import 'package:power_library/models/book.dart';
import 'package:power_library/screens/form.dart';
import '../components/bookTile.dart';

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

  List<Widget> _bookTiles = [];
  int _delay = 0;

  void _loadList() {
    _myBooks.forEach((Book b) {
      _delay += 200;

      Future.delayed(Duration(milliseconds: _delay), () {
        _bookTiles.add(BookTile(book: b));
        _listKey.currentState.insertItem(_bookTiles.length - 1);
      });
    });
  }

  int readBooksCount() {
    return _myBooks.where((book) => book.isRead).length;
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  var _tweenInsert = Tween(begin: Offset(1, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Power Library"),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          // mainAxisAligfromRGBO(58, 66, 86, 1.0nment: MainAxisAlignment
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
              child: AnimatedList(
                  key: _listKey,
                  initialItemCount: _bookTiles.length,
                  itemBuilder: (ctx, index, animation) => SlideTransition(
                        position: animation.drive(_tweenInsert),
                        child: _bookTiles[index],
                      )),
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
