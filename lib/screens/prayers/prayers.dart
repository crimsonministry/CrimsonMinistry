import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './addprayer.dart';

class Prayers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/addprayer': (BuildContext context) => new AddPrayerPage(),
      },
      home: new PrayersPage(),
    );
  }
}

class PrayersPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<PrayersPage> {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
        title: Text(document['title']),
        subtitle: Text(document['description']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Prayers"),
          backgroundColor: Colors.red,
        ),
        body: Column(children: [
          Flexible(
            child: StreamBuilder(
                stream: Firestore.instance.collection('prayers').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("No Prayer Requests At This Time...");
                  }
                  return ListView.builder(
                      itemExtent: 80.0,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return _buildList(
                            context, snapshot.data.documents[index]);
                      });
                }),
          ),
          Flexible(
            child: RaisedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/addevent');
              },
              child: const Text('Add Event', style: TextStyle(fontSize: 20)),
            ),
          )
        ]));
  }
}
