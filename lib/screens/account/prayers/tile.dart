import 'package:CrimsonMinistry/screens/account/prayers/edit.dart';
import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/prayer.dart';

class PrayerTile extends StatelessWidget {
  final Prayer prayer;
  PrayerTile({this.prayer});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: Icon(Icons.menu_book),
        title: Text(prayer.title),
        subtitle: Text(prayer.description),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            child: const Text('View'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPrayerPage(prayer: prayer),
                ),
              );
            },
          ),
        ],
      )
    ]));
  }
}
