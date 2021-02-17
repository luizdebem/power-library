import 'package:flutter/material.dart';
import './utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CreateMaterialColor(Color(0xFF141D2B)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            Expanded(child: Text("Hello World")),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(
                    20.0, isIOS ? 20.0 : 10.0, 20.0, isIOS ? 22.0 : 10.0),
                decoration: BoxDecoration(color: Colors.teal),
                child: Text("Livros Lidos: 4/10",
                    style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: "Adicionar Livro",
        child: Icon(Icons.add),
      ),
    );
  }
}
