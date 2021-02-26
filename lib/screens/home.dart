import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:power_library/models/book.dart';
import 'package:power_library/screens/form.dart';
import 'package:power_library/services/database.dart';
import 'package:provider/provider.dart';
import '../components/bookTile.dart';
import 'package:firestore_ui/animated_firestore_list.dart';
import '../services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  Widget build(BuildContext context) {
    final _tweenInsert = Tween(begin: Offset(1, 0), end: Offset(0, 0))
        .chain(CurveTween(curve: Curves.ease));

    final user = Provider.of<User>(context);
    print(user.photoURL);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 40,
                      backgroundImage: user.photoURL != null
                          ? NetworkImage("user?.photoURL")
                          : NetworkImage("https://i.imgur.com/7qXQhun.png")),
                  Divider(),
                  Text(user.displayName != ""
                      ? user.displayName
                      : "Usuário Anônimo"),
                ],
              ),
              decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Power Library"),
        elevation: 0,
        actions: [
          FlatButton.icon(
              onPressed: () async {
                try {
                  await AuthService().signOut();
                } catch (e) {
                  print(e);
                }
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                "Sair",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          // mainAxisAligfromRGBO(58, 66, 86, 1.0nment: MainAxisAlignment
          //     .center, // essa linha diz: alinha o main axis (y) pro centro em relação ao teu elemento-pai.
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FirestoreAnimatedList(
                query: DatabaseService().booksQuery,
                itemBuilder: (ctx, data, animation, index) {
                  Book b = Book.fromJson({'id': data.id, ...data.data()});

                  return SlideTransition(
                    position: animation.drive(_tweenInsert),
                    child: BookTile(book: b),
                  );
                },
              ),
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
