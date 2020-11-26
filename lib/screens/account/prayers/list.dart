import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'tile.dart';

class PrayerList extends StatefulWidget {
  @override
  _PrayerListState createState() => _PrayerListState();
}

class _PrayerListState extends State<PrayerList> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    var prayers = Provider.of<List<Prayer>>(context) ?? [];
    prayers = prayers.where((i) => i.userID == user.uid).toList();
    prayers.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: prayers.length,
      itemBuilder: (context, index) {
        return PrayerTile(prayer: prayers[index]);
      },
    );
  }
}
