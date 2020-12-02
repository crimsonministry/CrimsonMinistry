import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'eventtile.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';

class EventList extends StatefulWidget {
  final String type;
  EventList(this.type);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<Event> events = List<Event>();

  @override
  Widget build(BuildContext context) {
    events = Provider.of<List<Event>>(context) ?? [];
    final now = DateTime.now();
    events =
        events.where((i) => i.dateTime.toUtc().isAfter(now) == true).toList();
    if (widget.type != 'All') {
      events = events.where((i) => i.typeOfEvent == widget.type).toList();
    }
    events.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().users,
        child: RefreshIndicator(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventTile(event: events[index]);
              },
            ),
            onRefresh: () async {
              events = Provider.of<List<Event>>(context) ?? [];
              final now = DateTime.now();
              events = events
                  .where((i) => i.dateTime.toUtc().isAfter(now) == true)
                  .toList();
              if (widget.type != 'All') {
                events = events.where((i) => i.typeOfEvent == widget.type).toList();
              }
              return events.sort((a, b) => a.dateTime.compareTo(b.dateTime));
            },
    )
    );
  }
}
