// Book Request is made in this page
import 'package:cc_donate/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'services/crudd.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String bookName;
  String bookAuthor;
  String bookEdition;
  String bookRequest;
  String requesterAddress;
  QuerySnapshot books;
  QuerySnapshot resur;

  crudeMethods crudObj = new crudeMethods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Request Books',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: "book's name",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      labelText: 'Enter the name of the book:',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (value) {
                      this.bookName = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Author's name",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      labelText: 'Enter the author of the book:',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (value) {
                      this.bookAuthor = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Username',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      labelText: "Requested By:",
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (value) {
                      this.bookRequest = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'mobile number',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      labelText: 'Enter your contact number',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (value) {
                      this.bookEdition = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "your address",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      labelText: "Requester's address",
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (value) {
                      this.requesterAddress = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Request'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  Map bookData = {
                    'bookName': this.bookName,
                    'bookAuthor': this.bookAuthor,
                    'bookEdition': this.bookEdition,
                    'bookRequest': this.bookRequest,
                    'requesterAddress': this.requesterAddress
                  };
                  crudObj.getDData(bookData['bookName']).then((results) {
                    setState(() {
                      resur = results;
                      if (results.docs.length == 0) {
                        crudObj.addData(bookData).then((result) {
                          Fluttertoast.showToast(
                              msg: "Your Book is Requested",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }).catchError((e) {
                          print(e);
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "This Book is Already Available in Donated Book Section. Please Check once.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  });
                  print(resur);
                  print(resur.docs.length);
                  // if (resur.docs.length == 0) {
                  //   crudObj.addData(bookData).then((result) {
                  //     Fluttertoast.showToast(
                  //         msg: "Your Book is Requested",
                  //         toastLength: Toast.LENGTH_SHORT,
                  //         gravity: ToastGravity.CENTER,
                  //         timeInSecForIosWeb: 3,
                  //         backgroundColor: Colors.red,
                  //         textColor: Colors.white,
                  //         fontSize: 16.0);
                  //   }).catchError((e) {
                  //     print(e);
                  //   });
                  // } else {
                  //   Fluttertoast.showToast(
                  //       msg:
                  //           "This Book is Already Available in Donated Book Section. Please Check once.",
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIosWeb: 5,
                  //       backgroundColor: Colors.red,
                  //       textColor: Colors.white,
                  //       fontSize: 16.0);
                  // }
                  // crudObj.addData(bookData).then((result) {}).catchError((e) {
                  //   print(e);
                  // });
                },
              )
            ],
          );
        });
  }

  // verifyData(bookData) async {
  //   QuerySnapshot dBooks;
  //   await crudObj.getdData().then((result) {
  //     dBooks = result;
  //     for (var i = 0; i < dBooks.docs.length; i++) {
  //       String temp = dBooks.docs[i].data()['bookName'];
  //       String temp2 = bookData['bookName'];
  //       print(temp + "==" + temp2);
  //       if (temp2 == temp) {
  //         setState(() {
  //           res = false;
  //         });
  //         break;
  //       } else {
  //         setState(() {
  //           res = true;
  //         });
  //       }
  //     }
  //   });
  // }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Done', style: TextStyle(fontSize: 15.0)),
            content: Text('Requested!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        books = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return new Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
            backgroundColor: Color(0xff8c52ff),
            title: Text('Requested Books'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  addDialog(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  crudObj.getData().then((results) {
                    setState(() {
                      books = results;
                    });
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ]),
        body: _bookList());
  }

  Widget _bookList() {
    if (books != null) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.blueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/login.png',
                      fit: BoxFit.contain, height: 100),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.deepOrange,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Text("Didn't find your Book??",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Request here for your books...',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              Text(
                                  'We will try to make it available\n as soon as possible, Thanks!',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: books.docs.length,
                itemBuilder: (BuildContext context, int i) => Card(
                  child: Card(
                    color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Book Name  : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            Text('Book Author : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            Text('Requested By: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            Text('Mobile Number ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            Text('Requester Address: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(books.docs[i].data()['bookName'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w800)),
                            Text(books.docs[i].data()['bookAuthor'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w800)),
                            Text(books.docs[i].data()['bookRequest'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w800)),
                            Text(books.docs[i].data()['bookEdition'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w800)),
                            Text(books.docs[i].data()['requesterAddress'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/book1.png'),
                          minRadius: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Text('OOPS!! No Result Found.....',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 30.0));
    }
  }
}
