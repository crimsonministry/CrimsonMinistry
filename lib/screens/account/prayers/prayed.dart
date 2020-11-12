import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'package:CrimsonMinistry/screens/prayers/prayerTile.dart';

class PrayerList extends StatefulWidget {
  @override
  _PrayerListState createState() => _PrayerListState();
}

class _PrayerListState extends State<PrayerList> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    dynamic prayers = Provider.of<List<Prayer>>(context) ?? [];
    prayers = prayers.where((i) => i.userID == user.uid).toList();
    print(prayers);

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

// this widget needs to be modified
// currelty, it displays the list of user created prayers
// it should display all of the prayed prayers instead
