import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/event.dart';
import './detail.dart';

class EventTile extends StatelessWidget {
  final Event event;
  EventTile({this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: (event.typeOfEvent == 'Worship')
              ? Icon(
                  Icons.audiotrack,
                  color: Colors.blueGrey[900],
                  size: 35,
                )
              : Icon(Icons.import_contacts,
                  color: Colors.blueGrey[900], size: 35),
          title: Text(event.title),
          subtitle: Text(
              '${event.dateTime.month}/${event.dateTime.day}/${event.dateTime.year} @ ${event.dateTime.hour}:${event.dateTime.minute}'),
          trailing: Icon(Icons.more_vert),
          isThreeLine: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(event: event),
              ),
            );
          }),
    );
  }
}
