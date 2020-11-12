import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/widgets/drawer.dart';

class Map extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () async {
              // add event
            },
            child: Icon(
              Icons.add,
              size: 26.0,
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Text('this is where the map goes'),
    );
  }
}
