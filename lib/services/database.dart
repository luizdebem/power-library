import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');

  Stream<QuerySnapshot> get booksStream => booksCollection.snapshots();

  Query get booksQuery => booksCollection.orderBy('title');

  Future<DocumentReference> addBook(Map<String, dynamic> data) =>
      booksCollection.add(data);
}
