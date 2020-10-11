import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          RaisedButton(
            onPressed: () async {
              dynamic result = await _auth.signOut();
              print(result);
            },
            child: const Text('Sign Out', style: TextStyle(fontSize: 20)),
          ),
        ]));
  }
}
