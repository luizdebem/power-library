import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');

  Stream<QuerySnapshot> get booksStream => booksCollection.snapshots();

  Future<QuerySnapshot> get booksQuery =>
      booksCollection.orderBy('title').get();
}
