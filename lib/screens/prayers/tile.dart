import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import './detail.dart';

class PrayerTile extends StatelessWidget {
  final Prayer prayer;
  PrayerTile({this.prayer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Icon(
            Icons.favorite_border,
            color: Colors.blueGrey[900],
            size: 35,
          ),
          title: Text(prayer.title),
          subtitle: Text('${prayer.description}'),
          trailing: Icon(Icons.more_vert),
          isThreeLine: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(prayer: prayer),
              ),
            );
          }),
    );
  }
}
