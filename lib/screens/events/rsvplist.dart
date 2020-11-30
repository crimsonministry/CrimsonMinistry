import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';
import './rsvptile.dart';

class RSVPList extends StatefulWidget {
  final List<String> rsvp;
  RSVPList(this.rsvp);

  @override
  _RSVPListState createState() => _RSVPListState();
}

class _RSVPListState extends State<RSVPList> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
        value: DatabaseService().users,
        child: Scaffold(
            appBar: AppBar(
              title: Text('RSVP List'),
              backgroundColor: Colors.red,
            ),
            body: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.rsvp.length,
              itemBuilder: (context, index) {
                return RSVPTile(userID: widget.rsvp[index]);
              },
            )));
  }
}
