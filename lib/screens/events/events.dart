import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/widgets/drawer.dart';
import 'package:CrimsonMinistry/screens/map/map.dart';
import './list.dart';
import './add.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final point = LatLng(0.0, 0.0);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/addevent': (BuildContext context) => new AddEventPage(point: point),
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
  String typeOfEvent = 'All';

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Event>>.value(
      value: DatabaseService().events,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Events"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            DropdownButton<String>(
              dropdownColor: Colors.red,
              iconEnabledColor: Colors.white,
              style: TextStyle(color: Colors.white, fontSize: 20),
              value: typeOfEvent,
              items: <String>[
                'All',
                'Mission',
                'Bible Study',
                'Worship',
                'Volunteer'
              ].map((String value) {
                return new DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      width: 100,
                      alignment: Alignment.centerLeft,
                      child: new Text(value, textAlign: TextAlign.left), //Text
                    ));
              }).toList(),
              onChanged: (val) {
                print(typeOfEvent);
                setState(() => typeOfEvent = val);
                print(val);
              },
            ),
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
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        drawer: DrawerWidget(),
        body: Container(child: EventList(typeOfEvent)),
      ),
    );
  }
}
