import 'package:flutter/material.dart';
import 'package:cc_donate/pages/Home/home.dart';
import 'package:cc_donate/pages/Home/request.dart';
import 'package:cc_donate/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _children = [DashboarddPage(), DashboardPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8c52ff),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple,
        elevation: 1.0,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Request Book'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[500],
        onTap: _onItemTapped,
      ),
    );
  }
}
