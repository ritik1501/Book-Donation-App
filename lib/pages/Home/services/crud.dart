// Crud file for Book-Donate
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class crudeMethods {
  Future<void> addData(bookDat) async {
    bookDat = new Map<String, dynamic>.from(bookDat);
    await FirebaseFirestore.instance
        .collection('Book-Donation')
        .add(bookDat) //data to be entered
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance
        .collection('Book-Donation')
        .getDocuments();
  }

  getDData(searchy) async {
    return await FirebaseFirestore.instance
        .collection('Book-Donation')
        .orderBy('bookName')
        .startAt([searchy]).getDocuments();
  }
}
