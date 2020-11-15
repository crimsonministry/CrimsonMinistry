import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/screens/events/tile.dart';

class RSVPList extends StatefulWidget {
  @override
  _RSVPListState createState() => _RSVPListState();
}

class _RSVPListState extends State<RSVPList> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            dynamic events = Provider.of<List<Event>>(context) ?? [];
            events = events
                .where((i) => userData.rsvpedList.contains(i.id))
                .toList();
            print(events);

            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventTile(event: events[index]);
              },
            );
          } else {
            return Text('loading...');
          }
        });
  }
}

// this widget needs to be modified
// it currently print the user's list of created events
// it should print all rsvped events
