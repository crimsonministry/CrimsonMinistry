import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';

class Account extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<Account> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Account"),
          backgroundColor: Colors.red,
        ),
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
