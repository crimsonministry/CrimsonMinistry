import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'detail.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';

class PrayerTile extends StatefulWidget {
  final Prayer prayer;

  PrayerTile({this.prayer});

  @override
  _PrayerTileState createState() => _PrayerTileState();
}

class _PrayerTileState extends State<PrayerTile> {
  List<UserData> users = List<UserData>();

  @override
  Widget build(BuildContext context) {
    users = Provider.of<List<UserData>>(context) ?? [];
    int userIndex = users.indexWhere((user) => user.uid == widget.prayer.userID);
    UserData creatorData = users[userIndex];

    return StreamProvider<List<UserData>>.value(
        value: DatabaseService().users,
        child: Card(
           child: ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.deepOrange[700],
                size: 50,
              ),
              title: Text(widget.prayer.title),
              subtitle: Text(
                  '${widget.prayer.description}\nCreated on ${widget.prayer.createdAt.month}/${widget.prayer.createdAt.day}/${widget.prayer.createdAt.year}'),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(prayer: widget.prayer, creatorData: creatorData),
                  ),
                );
              }),
    )
    );
  }
}
