import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/event.dart';

class DetailPage extends StatelessWidget {
  final Event event;
  DetailPage({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(event.description),
      ),
    );
  }
}
