// Crud file for Book-Request

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class crudeMethods {
  Future<void> addData(bookData) async {
    bookData = new Map<String, dynamic>.from(bookData);
    await FirebaseFirestore.instance
        .collection('Book-Request')
        .add(bookData) //data to be entered
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance
        .collection('Book-Request')
        .getDocuments();
  }

  getDData(value) {
    return FirebaseFirestore.instance
        .collection('Book-Donation')
        .where('bookName', isEqualTo: value)
        .getDocuments();
  }
}
