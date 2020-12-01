import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/services/database.dart';
import './rsvplist.dart';

class DetailPage extends StatelessWidget {
  final DatabaseService _data = DatabaseService();
  final Event event;
  DetailPage({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
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
                        subtitle: Text(
                            '${event.location.latitude.truncateToDouble()}, ${event.location.longitude.truncateToDouble()}'),
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
                        margin: EdgeInsets.only(top: 30),
                        child: RaisedButton(
                          child: (event.rsvp.contains(user.uid))
                              ? const Text('Remove from RSVP')
                              : const Text('RSVP'),
                          color: Colors.red[300],
                          onPressed: () async {
                            if (event.rsvp.contains(user.uid)) {
                              event.rsvp.remove(user.uid);
                              userData.rsvpedList.remove(event.id);
                              await _data.addToRSVP(user.uid,
                                  userData.rsvpedList, event.id, event.rsvp);
                            } else {
                              event.rsvp.add(user.uid);
                              userData.rsvpedList.add(event.id);
                              await _data.addToRSVP(user.uid,
                                  userData.rsvpedList, event.id, event.rsvp);
                            }
                          },
                        ),
                      ),
                      RaisedButton(
                        child: Text('View RSVP List'),
                        color: Colors.orange[300],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RSVPList(event.rsvp),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            );
          } else {
            return Text('loading...');
          }
        });
  }
}
