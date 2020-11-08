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
  final _formKey = GlobalKey<FormState>();
  String error = '';

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Event edited!"),
      content: Text("Thanks for the update :))"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDeletedDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Event deleted!"),
      content: Text("Thanks for the update :))"),
    );
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
    final node = FocusScope.of(context);

    TextEditingController title =
        new TextEditingController(text: widget.event.title);
    ;
    TextEditingController location =
        new TextEditingController(text: widget.event.location);
    ;
    TextEditingController description =
        new TextEditingController(text: widget.event.description);
    ;
    DateTime pickedDate = widget.event.dateTime;
    String typeOfEvent = widget.event.typeOfEvent;

    return new Scaffold(
        appBar: AppBar(
          title: Text("Edit Event"),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                        child: Text('Type, Date, and Time',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            OutlineButton(
                              child: Text("$typeOfEvent"),
                              onPressed: null,
                            ),
                            SizedBox(width: 5),
                            OutlineButton(
                              child: Text(
                                  "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}"),
                              onPressed: null,
                            ),
                            SizedBox(width: 5),
                            OutlineButton(
                              child: Text(
                                  "${pickedDate.hour}:${pickedDate.minute}"),
                              onPressed: null,
                            ),
                          ]),
                      TextFormField(
                        onEditingComplete: () => node.nextFocus(),
                        controller: title,
                        decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Title cannot be null';
                          else
                            return null;
                        },
                      ),
                      TextFormField(
                        onEditingComplete: () => node.nextFocus(),
                        controller: location,
                        decoration: InputDecoration(
                            labelText: 'Location',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Location cannot be null';
                          else
                            return null;
                        },
                      ),
                      TextFormField(
                        onEditingComplete: () => node.nextFocus(),
                        controller: description,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          await _data.deleteEvent(widget.event.id);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          showDeletedDialog(context);
                        },
                        child: Text('Delete Event'),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await _data.updateEvent(widget.event.id, title.text,
                                location.text, description.text);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            showAlertDialog(context);
                          }
                        },
                        child: Text('Submit Changes'),
                      ),
                    ],
                  ))),
        ]));
  }
}
