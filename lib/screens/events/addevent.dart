import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final DatabaseService _data = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String location = '';
  String time = '';
  String typeOfEvent = '';
  String description = '';
  String error = '';

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
    User user = Provider.of<User>(context);
    final node = FocusScope.of(context);
    return new Scaffold(
        appBar: AppBar(
          title: Text("Create Event"),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 15.0, left: 40.0, right: 40.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  DropdownButtonFormField<String>(
                    items:
                        <String>['Bible Study', 'Worship'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => typeOfEvent = val);
                      print(typeOfEvent);
                    },
                    decoration: InputDecoration(
                        labelText: 'Type',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    validator: (value) {
                      if (value == null)
                        return 'Event type cannot be null';
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    onEditingComplete: () => node.nextFocus(),
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
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Title cannot be null';
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    onEditingComplete: () => node.nextFocus(),
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
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Location cannot be null';
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    onEditingComplete: () => node.nextFocus(),
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
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Time cannot be null';
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onEditingComplete: () => node.nextFocus(),
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
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _data.updatePostData(user.uid,
                            location, time, title, typeOfEvent, description);
                        showAlertDialog(context);
                        Navigator.of(context).pop();
                        print(result);
                        if (result == null) {
                          setState(() {
                            error = "couldn't add event";
                          });
                        }
                      }
                    },
                    child: Text('Create Event'),
                  ),
                ]),
              )),
        ]));
  }
}
