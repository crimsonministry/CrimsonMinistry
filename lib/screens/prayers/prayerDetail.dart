import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'package:CrimsonMinistry/services/database.dart';

class DetailPage extends StatelessWidget {
  final DatabaseService _data = DatabaseService();
  final Prayer prayer;
  DetailPage({Key key, @required this.prayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(prayer.title),
        backgroundColor: Colors.red,
      ),
      body: Column(children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(prayer.description),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8.0, 175.0, 0.0, 0.0),
                child: RaisedButton(
                  child: const Text('Pray'),
                  onPressed: () async {
                    /*if (prayer.prayerInteractions.contains(user.uid)) {
                      print('show error: you are on the prayerInteractions already');
                    } else {
                      prayer.prayerInteractions.add(user.uid);
                      await _data.addToPrayerInteractions(prayer.id, prayer.prayerInteractions);
                    }
                    print(prayer.prayerInteractions);*/
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
