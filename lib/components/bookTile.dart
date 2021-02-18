import 'package:flutter/material.dart';
import 'package:power_library/models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;

  BookTile({Key key, this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.author),
      leading: Icon(Icons.book),
      trailing: book.isRead
          ? Icon(Icons.check_box_outlined)
          : Icon(Icons.check_box_outline_blank),
    );
  }
}
