import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'edit.dart';

class DetailPage extends StatelessWidget {
  final DatabaseService _data = DatabaseService();
  final Event event;
  DetailPage({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        backgroundColor: Colors.red,
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEventPage(event: event),
                ),
              );
            },
            child: Text(
              "Edit",
              textScaleFactor: 1.5,
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(event.description),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(8.0, 175.0, 0.0, 0.0),
                  child: Text("show the list of RSVPs here")),
            ],
          ),
        ),
      ]),
    );
  }
}
