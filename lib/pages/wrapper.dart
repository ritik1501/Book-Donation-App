import 'package:cc_donate/models/user.dart';
import 'package:cc_donate/pages/authentication/authenticate.dart';
import 'package:cc_donate/pages/Home/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either the Home or Authenticate widget
    final user = Provider.of<Customer>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
