import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'detail.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';

class EventTile extends StatefulWidget {
  final Event event;
  EventTile({this.event});

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
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

  List<UserData> users = List<UserData>();

  @override
  Widget build(BuildContext context) {
    users = Provider.of<List<UserData>>(context) ?? [];
    int userIndex = users.indexWhere((user) => user.uid == widget.event.userID);
    UserData creatorData = users[userIndex];

    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().users,
        child: Card(
            child: ListTile(
                leading: switchIcons(widget.event.typeOfEvent),
                title: Text(widget.event.title),
                subtitle: Text(
                    '${widget.event.description}\nOn ${widget.event.dateTime.month}/${widget.event.dateTime.day}/${widget.event.dateTime.year} at ${widget.event.dateTime.hour}:${widget.event.dateTime.minute}'),
                trailing: Icon(Icons.more_vert),
                isThreeLine: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(event: widget.event, creatorData: creatorData),
                    ),
                  );
                }),
    )
    );
  }
}
