import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'prayertile.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';

class PrayerList extends StatefulWidget {
  @override
  _PrayerListState createState() => _PrayerListState();
}

class _PrayerListState extends State<PrayerList> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now().subtract(new Duration(days: 10));
    var prayers = Provider.of<List<Prayer>>(context) ?? [];
    prayers = prayers.where((i) => i.createdAt.isAfter(now) == true).toList();
    prayers.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return StreamProvider<List<UserData>>.value(
      value: DatabaseService().users,
        child: RefreshIndicator(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: prayers.length,
              itemBuilder: (context, index) {
                return PrayerTile(prayer: prayers[index]);
              },
            ),
            onRefresh: () async {
              prayers = Provider.of<List<Prayer>>(context) ?? [];
              prayers =
                  prayers.where((i) => i.createdAt.isAfter(now) == true).toList();
              prayers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            },
      )
    );
  }
}
