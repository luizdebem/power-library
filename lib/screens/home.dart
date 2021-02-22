import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:power_library/models/book.dart';
import 'package:power_library/screens/form.dart';
import 'package:provider/provider.dart';
import '../components/bookTile.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _bookTiles = [];
  int _delay = 0;

  void _loadList(QuerySnapshot books) async {
    setState(() {
      _bookTiles.clear();
      _listKey = GlobalKey<AnimatedListState>();
      _delay = 0;

      books.docs.forEach((data) {
        Book b = Book.fromJson({'id': data.id, ...data.data()});
        print(b.toString());
        _delay += 200;

        Future.delayed(Duration(milliseconds: _delay), () {
          _bookTiles.add(BookTile(book: b));
          _listKey.currentState.insertItem(_bookTiles.length - 1);
        });
      });
    });
  }

  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  var _tweenInsert = Tween(begin: Offset(1, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<QuerySnapshot>(context);
    _loadList(books);

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Power Library"),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          // mainAxisAligfromRGBO(58, 66, 86, 1.0nment: MainAxisAlignment
          //     .center, // essa linha diz: alinha o main axis (y) pro centro em relação ao teu elemento-pai.
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: AnimatedList(
                  key: _listKey,
                  initialItemCount: _bookTiles.length,
                  itemBuilder: (ctx, index, animation) => SlideTransition(
                        position: animation.drive(_tweenInsert),
                        child: _bookTiles[index],
                      )),
            ),
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
