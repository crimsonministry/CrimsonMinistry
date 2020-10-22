import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';
import './events.dart';
import './prayers.dart';
import './friends.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyEvents(),
                ),
              );
            },
            child: const Text('My Events', style: TextStyle(fontSize: 20)),
          ),
          RaisedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPrayers(),
                ),
              );
            },
            child: const Text('My Prayer Requests',
                style: TextStyle(fontSize: 20)),
          ),
          RaisedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyFriends(),
                ),
              );
            },
            child: const Text('My Friends', style: TextStyle(fontSize: 20)),
          ),
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
