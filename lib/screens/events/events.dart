import 'package:flutter/material.dart';
import './addevent.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/addevent': (BuildContext context) => new AddEventPage(),
      },
      home: new EventsPage(),
    );
  }
}

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () async {
              Navigator.of(context).pushNamed('/addevent');
            },
            child: Icon(
              Icons.add,
              size: 26.0,
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Column(children: <Widget>[
        // this is where the feed goes
      ]),
    );
  }
}
