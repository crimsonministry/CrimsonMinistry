import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:provider/provider.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccount> {
  final DatabaseService _data = DatabaseService();
  String fname = '';
  String lname = '';
  String username = '';
  String bio = '';

  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return new Scaffold(
        appBar: AppBar(
          title: Text('Edit Account'),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (val) {
                        setState(() => fname = val);
                        print(fname);
                      },
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      onChanged: (val) {
                        setState(() => lname = val);
                        print(lname);
                      },
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      onChanged: (val) {
                        setState(() => username = val);
                        print(username);
                      },
                      decoration: InputDecoration(
                          labelText: 'Username',
                          prefixText: '@',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 50.0),
                    RaisedButton(
                      onPressed: () async {
                        dynamic result = await _data.updateAccountPageData(
                            user.uid, fname, lname, username);
                        print(result);
                      },
                      child: const Text('Save Account Changes',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ))
          ],
        ));
  }
}
