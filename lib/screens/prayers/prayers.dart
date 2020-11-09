import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import './prayerList.dart';
import './addPrayer.dart';

class Prayers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/addPrayer': (BuildContext context) => new AddPrayerPage(),
      },
      home: new PrayersPage(),
    );
  }
}

class PrayersPage extends StatefulWidget {
  @override
  _PrayersPageState createState() => _PrayersPageState();
}

class _PrayersPageState extends State<PrayersPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Prayer>>.value(
      value: DatabaseService().prayers,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Prayers"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                Navigator.of(context).pushNamed('/addPrayer');
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
