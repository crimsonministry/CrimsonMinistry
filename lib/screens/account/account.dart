//import 'dart:html';
//import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/screens/account/editaccount.dart';
import 'package:provider/provider.dart';
import 'events/events.dart';
import 'friends/prayers.dart';
import 'friends/friends.dart';

class Account extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<Account> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return new Scaffold(
                appBar: AppBar(
                  title: Text("Account"),
                  backgroundColor: Colors.red,
                  actions: <Widget>[
                    FlatButton(
                      textColor: Colors.white,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditAccount(userData: userData),
                          ),
                        );
                      },
                      child: Text(
                        "Edit",
                        textScaleFactor: 1.5,
                        style: new TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                resizeToAvoidBottomPadding: false,
                body: Column(
                  children: <Widget>[
                    Container(
                      child: Container(
                        width: double.infinity,
                        height: 350.0,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Text('Avatar'),
                                radius: 35.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${userData.fname} ${userData.lname}',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '@${userData.username}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                'Ministry: ${userData.ministry}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${userData.bio}',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black),
                                softWrap: true,
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyPrayers(),
                                    ),
                                  );
                                },
                                child: const Text('My Prayer Requests',
                                    style: TextStyle(fontSize: 13)),
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyEvents(),
                                    ),
                                  );
                                },
                                child: const Text('My Events',
                                    style: TextStyle(fontSize: 13)),
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyFriends(),
                                    ),
                                  );
                                },
                                child: const Text('My Friends',
                                    style: TextStyle(fontSize: 13)),
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  dynamic result = await _auth.signOut();
                                  print(result);
                                },
                                child: const Text('Sign Out',
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ));
          } else {
            return Text('loading...');
          }
        });
  }
}
