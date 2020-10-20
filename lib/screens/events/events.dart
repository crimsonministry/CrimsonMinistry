import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './addevent.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/addevent': (BuildContext context) => new AddEventPage(),
      },
      home: new EventsPage(),
    );
  }
}

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: Icon(Icons.menu_book),
        title: Text(document['title']),
        subtitle: Text(document['description'] + ' - ' + document['time']),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            child: const Text('RSVP'),
            onPressed: () {/* ... */},
          ),
          const SizedBox(width: 8),
          TextButton(
            child: const Text('View'),
            onPressed: () {/* ... */},
          ),
        ],
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Events"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                Navigator.of(context).pushNamed('/addevent');
              },
              child: Icon(
                Icons.add,
                size: 26.0,
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: Column(children: [
          Flexible(
            child: StreamBuilder(
                stream: Firestore.instance.collection('posts').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("No Events At This Time...");
                  }
                  return ListView.builder(
                      itemExtent: 128.0,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return _buildList(
                            context, snapshot.data.documents[index]);
                      });
                }),
          ),
        ]));
  }
}
