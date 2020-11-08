import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'edit.dart';

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
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPrayerPage(prayer: prayer),
                ),
              );
            },
            child: Text(
              "Edit",
              textScaleFactor: 1.5,
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(prayer.description),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(prayer.count.toString()),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
