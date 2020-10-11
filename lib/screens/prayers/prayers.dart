import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';
import 'package:CrimsonMinistry/screens/home/home.dart';
import 'package:CrimsonMinistry/screens/account/account.dart';

class Prayers extends StatefulWidget {
  @override
  _PrayersPageState createState() => _PrayersPageState();
}

class _PrayersPageState extends State<Prayers> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(8.0, 110.0, 0.0, 0.0),
              child: Text('Prayers',
                  style: TextStyle(
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red))),
        ]));
  }
}
