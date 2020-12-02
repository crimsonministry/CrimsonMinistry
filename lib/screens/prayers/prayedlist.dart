import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';
import './prayedtile.dart';

class PrayedList extends StatefulWidget {
  final List<String> prayed;
  PrayedList(this.prayed);

  @override
  _PrayedListState createState() => _PrayedListState();
}

class _PrayedListState extends State<PrayedList> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
        value: DatabaseService().users,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Prayed List'),
              backgroundColor: Colors.red,
            ),
            body: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.prayed.length,
              itemBuilder: (context, index) {
                return PrayedTile(userID: widget.prayed[index]);
              },
            )));
  }
}