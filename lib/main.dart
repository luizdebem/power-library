import 'package:flutter/material.dart';
import 'package:power_library/screens/book-form.dart';
import 'package:power_library/screens/home.dart';
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
        initialRoute: '/',
        routes: {'/': (ctx) => Home(), '/book-form': (ctx) => BookForm()});
  }
}
