// Book Donation is made in this page

import 'package:cc_donate/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'services/crud.dart';

class DashboarddPage extends StatefulWidget {
  @override
  _DashboarddPageState createState() => _DashboarddPageState();
}

class _DashboarddPageState extends State<DashboarddPage> {
  String bookName;
  String bookAuthor;
  String bookEdition;
  String bookDonor;
  String donorAddress;
  QuerySnapshot books;

  final TextEditingController _filter = new TextEditingController();
  String searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Donated Books');
  List filteredNames = new List();
  List names = new List();

  crudeMethods crudObj = new crudeMethods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Donate Books',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Book's name",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      labelText: "Enter the name of the book:",
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
                      labelText: "Enter the author of the book:",
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
                      hintText: 'username',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      labelText: "Donated By:",
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (value) {
                      this.bookDonor = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      labelText: "Enter your Contact number",
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
                      hintText: "City",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      labelText: "Donor's city",
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (value) {
                      this.donorAddress = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Donate'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  Map bookData = {
                    'bookName': this.bookName,
                    'bookAuthor': this.bookAuthor,
                    'bookNumber': this.bookEdition,
                    'bookDonor': this.bookDonor,
                    'bookAddress': this.donorAddress
                  };
                  crudObj.addData(bookData).then((result) {
                    Fluttertoast.showToast(
                        msg: "Your Book is Donated",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
          onChanged: (value) {
            this.searchText = value;
            crudObj.getDData(this.searchText).then((result) {
              setState(() {
                books = result;
              });
            });
          },
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Donated Books');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Done', style: TextStyle(fontSize: 15.0)),
            content: Text('Donated!!!'),
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
        backgroundColor: Color(0xff8c52ff),
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: _appBarTitle,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  _searchPressed();
                },
                icon: _searchIcon,
              ),
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
    if (books == null) {
      return Text('OOPS !! No Result Found.....',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 20.0));
    } else {
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
                    padding: EdgeInsets.only(left: 30.0),
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
                              Text('Welcome in Book ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              Text('Donation Application',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Text('Help India in becoming the most',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              Text('educated country in the world',
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
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/book1.png'),
                          minRadius: 50.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Book Name  : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            Text('Book Autor : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            Text('Donated By : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            Text('Contact No : ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0)),
                            Text('Address : ',
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
                                    fontSize: 15.0)),
                            Text(books.docs[i].data()['bookAuthor'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.0)),
                            Text(books.docs[i].data()['bookDonor'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.0)),
                            Text(books.docs[i].data()['bookNumber'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.0)),
                            Text(books.docs[i].data()['bookAddress'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15.0)),
                          ],
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
    }
  }
}
