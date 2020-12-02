import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/services/database.dart';
import './rsvplist.dart';

class DetailPage extends StatefulWidget {
  final DatabaseService _data = DatabaseService();
  final Event event;
  final UserData creatorData;
  DetailPage({Key key, @required this.event, this.creatorData}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
                title: Text(widget.event.typeOfEvent),
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
                            '${widget.event.dateTime.month}/${widget.event.dateTime.day}/${widget.event.dateTime.year} @ ${widget.event.dateTime.hour}:${widget.event.dateTime.minute}'),
                        leading: Icon(Icons.date_range,
                            color: Colors.blueGrey[900], size: 35),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Location',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text(
                            '${widget.event.location.latitude.truncateToDouble()}, ${widget.event.location.longitude.truncateToDouble()}'),
                        leading: Icon(Icons.location_on,
                            color: Colors.blueGrey[900], size: 35),
                      ),
                      ListTile(
                        title: Text('Description',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text('${widget.event.description}'),
                        leading: Icon(Icons.description,
                            color: Colors.blueGrey[900], size: 35),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Created by',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text('${widget.creatorData.fname} ${widget.creatorData.lname}'),
                        leading: Icon(Icons.account_circle,
                            color: Colors.blueGrey[900], size: 35),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: RaisedButton(
                          child: (widget.event.rsvp.contains(user.uid))
                              ? const Text('Remove from RSVP')
                              : const Text('RSVP'),
                          color: Colors.red[300],
                          onPressed: () async {
                            if (widget.event.rsvp.contains(user.uid)) {
                              widget.event.rsvp.remove(user.uid);
                              userData.rsvpedList.remove(widget.event.id);
                              await widget._data.addToRSVP(user.uid,
                                  userData.rsvpedList, widget.event.id, widget.event.rsvp);
                            } else {
                              widget.event.rsvp.add(user.uid);
                              userData.rsvpedList.add(widget.event.id);
                              await widget._data.addToRSVP(user.uid,
                                  userData.rsvpedList, widget.event.id, widget.event.rsvp);
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
                              builder: (context) => RSVPList(widget.event.rsvp),
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
