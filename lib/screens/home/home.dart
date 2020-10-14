import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';
import 'package:CrimsonMinistry/screens/prayers/prayers.dart';
import 'package:CrimsonMinistry/screens/account/account.dart';
import 'addevent.dart';
import 'addprayer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/addevent': (BuildContext context) => new AddEventPage(),
        '/addprayer': (BuildContext context) => new AddPrayerPage()
      },
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(8.0, 110.0, 0.0, 0.0),
              child: Text('Home',
                  style: TextStyle(
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red))),
          RaisedButton(
            onPressed: () async {
              dynamic result = await _auth.signOut();
              print(result);
            },
            child: const Text('Sign Out', style: TextStyle(fontSize: 20)),
          ),
          RaisedButton(
            onPressed: () async {
              Navigator.of(context).pushNamed('/addevent');
            },
            child: const Text('Add Event', style: TextStyle(fontSize: 20)),
          ),
          RaisedButton(
            onPressed: () async {
              Navigator.of(context).pushNamed('/addprayer');
            },
            child: const Text('Add Prayer', style: TextStyle(fontSize: 20)),
          ),
        ]));
  }
}
