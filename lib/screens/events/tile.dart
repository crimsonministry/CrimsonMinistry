import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/event.dart';
import './detail.dart';

class EventTile extends StatelessWidget {
  final Event event;
  EventTile({this.event});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {/* ... */},
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
