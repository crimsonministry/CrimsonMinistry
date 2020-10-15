import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Prayers extends StatelessWidget {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return ListTile(
        title: Text(document['title']),
        subtitle: Text(document['description']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayers Feed"),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('prayers').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("No Prayer Requests At This Time...");
            }
            return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return _buildList(context, snapshot.data.documents[index]);
                });
          }),
    );
  }
}
