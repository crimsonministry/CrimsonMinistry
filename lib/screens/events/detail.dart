import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/services/database.dart';

class DetailPage extends StatelessWidget {
  final DatabaseService _data = DatabaseService();
  final Event event;
  DetailPage({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(event.typeOfEvent),
        backgroundColor: Colors.red,
      ),
      body: Column(children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Date and Time',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(
                    '${event.dateTime.month}/${event.dateTime.day}/${event.dateTime.year} @ ${event.dateTime.hour}:${event.dateTime.minute}'),
                leading: Icon(Icons.date_range,
                    color: Colors.blueGrey[900], size: 35),
              ),
              Divider(),
              ListTile(
                title: Text('Location',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('${event.location}'),
                leading: Icon(Icons.location_on,
                    color: Colors.blueGrey[900], size: 35),
              ),
              ListTile(
                title: Text('Description',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('${event.description}'),
                leading: Icon(Icons.description,
                    color: Colors.blueGrey[900], size: 35),
              ),
              Divider(),
              ListTile(
                title: Text('Created by',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('${event.userID}'),
                leading: Icon(Icons.account_circle,
                    color: Colors.blueGrey[900], size: 35),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8.0, 30.0, 0.0, 0.0),
                child: RaisedButton(
                  child: const Text('RSVP'),
                  onPressed: () async {
                    if (event.rsvp.contains(user.uid)) {
                      print('show error: you are on the rsvp already');
                    } else {
                      event.rsvp.add(user.uid);
                      await _data.addToRSVP(event.id, event.rsvp);
                    }
                    print(event.rsvp);
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
