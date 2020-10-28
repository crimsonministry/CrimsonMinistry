import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';

class AddFriendPage extends StatefulWidget {
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final DatabaseService _data = DatabaseService();
  String username = '';

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Friend request sent!"),
      content: Text("Now just wait for them to accept :))"),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return new Scaffold(
        appBar: AppBar(
          title: Text("Add Friends"),
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
                      setState(() => username = val);
                      print(username);
                    },
                    decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(height: 50.0),
                  RaisedButton(
                    onPressed: () async {
                      print('backend to be implemented');
                      showAlertDialog(context);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Send Request',
                        style: TextStyle(fontSize: 20)),
                  ),
                ],
              )),
        ]));
  }
}
