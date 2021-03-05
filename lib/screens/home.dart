import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:power_library/models/book.dart';
import 'package:power_library/screens/form.dart';
import 'package:power_library/services/database.dart';
import 'package:provider/provider.dart';
import '../components/bookTile.dart';
import 'package:firestore_ui/animated_firestore_list.dart';
import '../services/auth.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _tweenInsert = Tween(begin: Offset(1, 0), end: Offset(0, 0))
        .chain(CurveTween(curve: Curves.ease));

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Power Library"),
        elevation: 0,
        actions: [
          FlatButton.icon(
              onPressed: () async {
                await AuthService().signOut();
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
                emptyChild: Center(
                    child: Text(
                  "Você não adicionou nenhum livro ainda!",
                  style: TextStyle(fontSize: 25.0),
                )),
                itemBuilder: (ctx, data, animation, index) {
                  print("BOM DIA JOSIAS");
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
