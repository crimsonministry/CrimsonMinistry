import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/services/database.dart';
import './detail.dart';

class EventTile extends StatelessWidget {
  final DatabaseService _data = DatabaseService();
  final Event event;
  EventTile({this.event});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: Icon(Icons.menu_book),
        title: Text(event.title),
        subtitle: Text(event.description),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
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
          TextButton(
            child: const Text('View'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(event: event),
                ),
              );
            },
          ),
        ],
      )
    ]));
  }
}
