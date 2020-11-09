import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/screens/prayers/addPrayer.dart';
import 'list.dart';

class MyPrayers extends StatefulWidget {
  @override
  _MyPrayersPageState createState() => _MyPrayersPageState();
}

class _MyPrayersPageState extends State<MyPrayers> {
  Widget build(BuildContext context) {
    return StreamProvider<List<Prayer>>.value(
      value: DatabaseService().prayers,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Prayers"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPrayerPage(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                size: 26.0,
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: Container(child: PrayerList()),
      ),
    );
  }
}
