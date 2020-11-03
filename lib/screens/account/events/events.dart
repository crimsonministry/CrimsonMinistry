import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/screens/events/addevent.dart';
import 'list.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEvents> {
  Widget build(BuildContext context) {
    return StreamProvider<List<Event>>.value(
      value: DatabaseService().events,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Events"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEventPage(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                size: 26.0,
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: Container(child: EventList()),
      ),
    );
  }
}
