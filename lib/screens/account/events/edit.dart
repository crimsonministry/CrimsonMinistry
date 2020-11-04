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

  showDeletedDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Event deleted!"),
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

    TextEditingController title =
        new TextEditingController(text: widget.event.title);
    ;
    TextEditingController location =
        new TextEditingController(text: widget.event.location);
    ;
    TextEditingController time =
        new TextEditingController(text: widget.event.time);
    ;
    TextEditingController typeOfEvent =
        new TextEditingController(text: widget.event.typeOfEvent);
    ;
    TextEditingController description =
        new TextEditingController(text: widget.event.description);
    ;

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
                  TextField(
                    controller: title,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    controller: location,
                    decoration: InputDecoration(
                        labelText: 'Location',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    controller: time,
                    decoration: InputDecoration(
                        labelText: 'Time',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    controller: typeOfEvent,
                    decoration: InputDecoration(
                        labelText: 'Type of Event',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    controller: description,
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
                      _data.deleteEvent(widget.event.id);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      showDeletedDialog(context);
                      // call function in database to update the changes
                    },
                    child: const Text('Delete', style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    onPressed: () async {
                      _data.updateEvent(widget.event.id, title.text, time.text,
                          location.text, typeOfEvent.text, description.text);
                      print(title.text);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      showAlertDialog(context);
                      // call function in database to update the changes
                    },
                    child: const Text('Submit', style: TextStyle(fontSize: 20)),
                  ),
                ],
              )),
        ]));
  }
}
