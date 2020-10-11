import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/screens/home/home.dart';
import 'package:CrimsonMinistry/screens/prayers/prayers.dart';

class Account extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(8.0, 110.0, 0.0, 0.0),
              child: Text('Account',
                  style: TextStyle(
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red))),
        ]));
  }
}
