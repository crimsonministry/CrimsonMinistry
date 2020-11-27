import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'tile.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    var events = Provider.of<List<Event>>(context) ?? [];
    events = events.where((i) => i.userID == user.uid).toList();
    events.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return RefreshIndicator(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventTile(event: events[index]);
        },
      ),
      onRefresh: () async {
        events = Provider.of<List<Event>>(context) ?? [];
        events = events.where((i) => i.userID == user.uid).toList();
        events.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      },
    );
  }
}
