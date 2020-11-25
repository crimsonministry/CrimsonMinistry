import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/screens/map/map.dart';
import 'list.dart';
import 'rsvp.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEvents> {
  Widget build(BuildContext context) {
    return StreamProvider<List<Event>>.value(
        value: DatabaseService().events,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text("My Events"),
              backgroundColor: Colors.red,
              bottom: TabBar(
                indicatorColor: Colors.red[100],
                tabs: [
                  Tab(text: 'Created'),
                  Tab(text: 'RSVPed'),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.white,
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapPage(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add,
                    size: 26.0,
                  ),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                Container(child: EventList()),
                Container(child: RSVPList()),
              ],
            ),
          ),
        ));
  }
}
