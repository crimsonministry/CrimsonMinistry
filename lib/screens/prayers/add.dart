import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';

class AddPrayerPage extends StatefulWidget {
  @override
  _AddPrayerPageState createState() => _AddPrayerPageState();
}

class _AddPrayerPageState extends State<AddPrayerPage> {
  final DatabaseService _data = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool beAnonymous = false;
  String title = '';
  String description = '';
  String error = '';

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Prayer added!"),
      content: Text("Thanks for your submission :)"),
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
    return new Scaffold(
        appBar: AppBar(
          title: Text("Add Prayer Request"),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 30.0, left: 40.0, right: 40.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                    child: Text('Anonymous Submission',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                  Switch(
                    value: beAnonymous,
                    onChanged: (value) {
                      setState(() {
                        beAnonymous = value;
                      });
                    },
                    activeTrackColor: Colors.lightBlueAccent,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: (val) {
                      setState(() => title = val);
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: (val) {
                      setState(() => description = val);
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'DescriptionTest cannot be null';
                      else
                        return null;
                    },
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await _data.addPrayerRequest(
                            user.uid, beAnonymous, title, description);
                        Navigator.of(context).pop();
                        showAlertDialog(context);
                      }
                    },
                    child: Text('Add Prayer Requests'),
                  ),
                ]),
              )),
        ]));
  }
}
