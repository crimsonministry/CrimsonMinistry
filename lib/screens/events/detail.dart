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
        title: Text(event.title),
        backgroundColor: Colors.red,
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
