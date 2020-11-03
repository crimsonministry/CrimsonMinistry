import 'package:flutter/material.dart';

class MyPrayers extends StatefulWidget {
  @override
  _MyPrayersPageState createState() => _MyPrayersPageState();
}

class _MyPrayersPageState extends State<MyPrayers> {
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("My Prayers"),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          // to be added
        ]));
  }
}