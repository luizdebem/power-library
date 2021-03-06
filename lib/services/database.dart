import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;

  DatabaseService({@required this.uid});

  final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');

  final booksBucket = FirebaseStorage.instance.ref();
  static final coverFolder = 'covers';

  Stream<QuerySnapshot> get booksStream =>
      booksCollection.where('uid', isEqualTo: uid).snapshots();

  Query get booksQuery =>
      booksCollection.where('uid', isEqualTo: uid).orderBy('title');

  Future<DocumentReference> addBook(Map<String, dynamic> data) =>
      booksCollection.add(data);

  Future<void> updateBook(String id, Map<String, dynamic> data) =>
      booksCollection.doc(id).update(data);

  Future<void> deleteBook(String id) => booksCollection.doc(id).delete();

  Future<String> uploadFile(File file) async {
    String path = "${coverFolder}/${DateTime.now()}.png";
    try {
      await booksBucket.child(path).putFile(file);
    } on FirebaseException catch (err) {
      print(err);
    }
    return path;
  }

  Future<String> getFileURL(path) async {
    return await FirebaseStorage.instance.ref(path).getDownloadURL();
  }
}
