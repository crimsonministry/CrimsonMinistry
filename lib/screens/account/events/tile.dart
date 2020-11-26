import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/event.dart';
import './edit.dart';

class EventTile extends StatelessWidget {
  final Event event;
  EventTile({this.event});

  switchIcons(String eventType) {
    switch (eventType) {
      case 'Bible Study':
        return Icon(
          Icons.book,
          color: Colors.lightGreen[700],
          size: 50,
        );
        break;
      case 'Mission':
        return Icon(
          Icons.explore,
          color: Colors.yellow[700],
          size: 50,
        );
        break;
      case 'Volunteer':
        return Icon(
          Icons.favorite,
          color: Colors.deepOrange[700],
          size: 50,
        );
        break;
      case 'Worship':
        return Icon(
          Icons.radio,
          color: Colors.cyan[700],
          size: 50,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: switchIcons(event.typeOfEvent),
          title: Text(event.title),
          subtitle: Text(
              '${event.description}\nOn ${event.dateTime.month}/${event.dateTime.day}/${event.dateTime.year} at ${event.dateTime.hour}:${event.dateTime.minute}'),
          trailing: Icon(Icons.more_vert),
          isThreeLine: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditEventPage(event: event),
              ),
            );
          }),
    );
  }
}
