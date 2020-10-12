import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/database.dart';

class AddPrayerPage extends StatefulWidget {
  @override
  _AddPrayerPageState createState() => _AddPrayerPageState();
}

class _AddPrayerPageState extends State<AddPrayerPage> {
  final DatabaseService _data = DatabaseService();
  String title = '';
  String description = '';

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Prayer added!"),
      content: Text("Thanks for your submission :)"),
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
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          SizedBox(height: 50.0),
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
                  SizedBox(height: 10.0),
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
                      await _data.updatePrayerData(title, description);
                      showAlertDialog(context);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add Prayer',
                        style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Text('GO BACK',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ]));
  }
}
