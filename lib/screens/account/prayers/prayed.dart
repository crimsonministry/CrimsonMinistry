import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'package:CrimsonMinistry/screens/prayers/prayertile.dart';

class PrayedList extends StatefulWidget {
  @override
  _PrayerListState createState() => _PrayerListState();
}

class _PrayerListState extends State<PrayedList> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            dynamic prayers = Provider.of<List<Prayer>>(context) ?? [];
            prayers = prayers
                .where((i) => userData.prayedList.contains(i.id))
                .toList();

            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: prayers.length,
              itemBuilder: (context, index) {
                return PrayerTile(prayer: prayers[index]);
              },
            );
          } else {
            return Text('loading...');
          }
        });
  }
}
