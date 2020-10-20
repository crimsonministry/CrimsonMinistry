import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/database.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final DatabaseService _data = DatabaseService();
  String title = '';
  String location = '';
  String time = '';
  String typeOfEvent = '';
  String description = '';

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Event added!"),
      content: Text("Thanks for your submission :))"),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Add Event"),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (val) {
                      setState(() => title = val);
                      print(title);
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    onChanged: (val) {
                      setState(() => location = val);
                      print(location);
                    },
                    decoration: InputDecoration(
                        labelText: 'Location',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    onChanged: (val) {
                      setState(() => time = val);
                      print(time);
                    },
                    decoration: InputDecoration(
                        labelText: 'Time',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    onChanged: (val) {
                      setState(() => typeOfEvent = val);
                      print(typeOfEvent);
                    },
                    decoration: InputDecoration(
                        labelText: 'Type of Event',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    onChanged: (val) {
                      setState(() => description = val);
                      print(description);
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(height: 50.0),
                  RaisedButton(
                    onPressed: () async {
                      await _data.updatePostData(
                          location, time, title, typeOfEvent, description);
                      showAlertDialog(context);
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('Add Event', style: TextStyle(fontSize: 20)),
                  ),
                ],
              )),
        ]));
  }
}
