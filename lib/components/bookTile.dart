import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:power_library/models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;

  BookTile({Key key, this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      color: Color.fromRGBO(64, 75, 96, 0.9),
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.hardEdge,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(right: 16),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.white24))),
              child: Image.asset(
                "assets/images/bookcover.png",
                width: 60.0,
                height: 80.0,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Container(
                height: 80.0,
                margin: EdgeInsets.only(right: 18.0, top: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(book.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0)),
                    Text(
                      book.author,
                      style: TextStyle(fontSize: 13.0, color: Colors.white70),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !book.isRead
                              ? Text(
                                  "Avaliação não disponível",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 13.0,
                                      color: Colors.white70),
                                )
                              : RatingBar.builder(
                                  initialRating: book.rate?.toDouble() ?? 0,
                                  ignoreGestures: true,
                                  minRating: 1,
                                  maxRating: 5,
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                  itemBuilder: (ctx, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                          book.isRead
                              ? DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Color(0xFF00CC00),
                                      borderRadius: BorderRadius.circular(6.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                    child: Text(
                                      "Finalizado",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
