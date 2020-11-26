import 'package:CrimsonMinistry/screens/account/prayers/edit.dart';
import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/prayer.dart';

class PrayerTile extends StatelessWidget {
  final Prayer prayer;
  PrayerTile({this.prayer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Icon(
            Icons.favorite,
            color: Colors.deepOrange[700],
            size: 50,
          ),
          title: Text(prayer.title),
          subtitle: Text(
              '${prayer.description}\nCreated on ${prayer.createdAt.month}/${prayer.createdAt.day}/${prayer.createdAt.year}'),
          trailing: Icon(Icons.more_vert),
          isThreeLine: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditPrayerPage(prayer: prayer),
              ),
            );
          }),
    );
  }
}
