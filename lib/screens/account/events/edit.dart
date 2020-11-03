import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/services/database.dart';

class EditEventPage extends StatefulWidget {
  @override
  final Event event;
  EditEventPage({Key key, @required this.event}) : super(key: key);
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final DatabaseService _data = DatabaseService();
  String title = '';
  String location = '';
  String time = '';
  String typeOfEvent = '';
  String description = '';

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Event edited!"),
      content: Text("Thanks for the update :))"),
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
    User user = Provider.of<User>(context);
    title = widget.event.title;
    location = widget.event.location;
    time = widget.event.time;
    typeOfEvent = widget.event.typeOfEvent;
    description = widget.event.description;

    return new Scaffold(
        appBar: AppBar(
          title: Text("Edit Event"),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: title,
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
                  TextFormField(
                    initialValue: location,
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
                  TextFormField(
                    initialValue: time,
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
                  TextFormField(
                    initialValue: typeOfEvent,
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
                  TextFormField(
                    initialValue: description,
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
                      // call function in database to update the changes
                    },
                    child: const Text('Submit', style: TextStyle(fontSize: 20)),
                  ),
                ],
              )),
        ]));
  }
}
