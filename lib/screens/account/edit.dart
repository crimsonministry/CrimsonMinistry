import 'dart:ui';

import 'package:CrimsonMinistry/screens/account/selectavatar.dart';
import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/screens/account/delete.dart';

class EditAccount extends StatefulWidget {
  @override
  final UserData userData;
  EditAccount({Key key, @required this.userData}) : super(key: key);
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccount> {
  final DatabaseService _data = DatabaseService();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    TextEditingController firstName =
        new TextEditingController(text: widget.userData.fname);
    TextEditingController lastName =
        new TextEditingController(text: widget.userData.lname);
    TextEditingController userName =
        new TextEditingController(text: widget.userData.username);
    TextEditingController bio =
        new TextEditingController(text: widget.userData.bio);
    TextEditingController ministry =
        new TextEditingController(text: widget.userData.ministry);
    TextEditingController twitterLink =
        new TextEditingController(text: widget.userData.twitter);
    TextEditingController facebookLink =
        new TextEditingController(text: widget.userData.facebook);
    TextEditingController instaLink =
        new TextEditingController(text: widget.userData.instagram);

    return new Scaffold(
        appBar: AppBar(
          title: Text('Edit Account'),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Stack(
          children: <Widget>[
            SizedBox(height: 50.0),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: firstName,
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: lastName,
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: userName,
                      decoration: InputDecoration(
                          labelText: 'Username',
                          prefixText: '@',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: ministry,
                      decoration: InputDecoration(
                          labelText: 'Ministry',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: bio,
                      decoration: InputDecoration(
                          labelText: 'Bio',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: twitterLink,
                      decoration: InputDecoration(
                          labelText: 'Twitter Link',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: facebookLink,
                      decoration: InputDecoration(
                          labelText: 'Facebook Link',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: instaLink,
                      decoration: InputDecoration(
                          labelText: 'Instagram Link',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 30.0),
                    RaisedButton(
                        color: Colors.red,
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectAvatarPage(),
                            ),
                          );
                        },
                        child: const Text('Upload Profile Image')),
                    RaisedButton(
                      color: Colors.blue[300],
                      onPressed: () async {
                        await _data.updateAccountPageData(
                            user.uid,
                            firstName.text,
                            lastName.text,
                            userName.text,
                            ministry.text,
                            bio.text,
                            twitterLink.text,
                            facebookLink.text,
                            instaLink.text);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save Changes'),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      color: Colors.red[300],
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeleteAccountPage(),
                          ),
                        );
                      },
                      child: const Text('Delete Account'),
                    ),
                  ],
                ))
          ],
        )));
  }
}
