import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'package:CrimsonMinistry/services/database.dart';
import './prayerDetail.dart';

class PrayerTile extends StatelessWidget {
  final DatabaseService _data = DatabaseService();
  final Prayer prayer;
  PrayerTile({this.prayer});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
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
                child: Text('Pray ${prayer.prayerInteractions.length}'),
                onPressed: () async {
                  if (prayer.prayerInteractions.contains(user.uid)) {
                    print('show error: You have already prayed');
                  } else {
                    prayer.prayerInteractions.add(user.uid);
                    await _data.addToPrayerInteractions(prayer.id, prayer.prayerInteractions);
                  }
                  print(prayer.prayerInteractions);
                },
              ),
              TextButton(
                child: const Text('View'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(prayer: prayer),
                    ),
                  );
                },
              ),
            ],
          )
        ]));
  }
}
