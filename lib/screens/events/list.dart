import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/event.dart';
import './tile.dart';

class EventList extends StatefulWidget {
  final String type;
  EventList(this.type);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    dynamic events = Provider.of<List<Event>>(context) ?? [];
    if(widget.type != 'All') {
      events = events
          .where((i) => i.typeOfEvent == widget.type)
          .toList();
    }
    print(widget.type);
    print(events);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventTile(event: events[index]);
      },
    );
  }
}
