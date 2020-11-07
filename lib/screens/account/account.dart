//import 'dart:html';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/screens/account/editaccount.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_icons.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'events/events.dart';
import 'prayers/prayers.dart';
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
                    FlatButton(
                        onPressed: () async {
                          dynamic result = await _auth.signOut();
                          print(result);
                        },
                        child: Text(
                          "Sign Out",
                          textScaleFactor: 1.5,
                          style: new TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
                resizeToAvoidBottomPadding: false,
                body: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Text('Avatar'),
                              radius: 50.0,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 44.0),
                              Text(
                                '${userData.fname} ${userData.lname}',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text('@${userData.username}',
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.red)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Container(
                        width: double.infinity,
                        height: 350.0,
                        child: Center(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Ministry: ',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${userData.ministry}',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${userData.bio}',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Column(
                                children: <Widget>[
                                  RaisedButton(
                                    color: Colors.red,
                                    colorBrightness: Brightness.dark,
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyPrayers(),
                                        ),
                                      );
                                    },
                                    child: const Text('My Prayers',
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  RaisedButton(
                                    color: Colors.red,
                                    colorBrightness: Brightness.dark,
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
                                    color: Colors.red,
                                    colorBrightness: Brightness.dark,
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
                                ],
                              ),
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                      iconSize: 32.0,
                                      icon: Icon(
                                        SocialMediaIcons.facebook_squared,
                                        color:
                                            Color.fromRGBO(66, 103, 178, 1.0),
                                      ),
                                      onPressed: null),
                                  IconButton(
                                      iconSize: 32.0,
                                      icon: Icon(SocialMediaIcons.instagram,
                                          color: Color.fromRGBO(
                                              225, 48, 108, 1.0)),
                                      onPressed: null),
                                  IconButton(
                                      iconSize: 32.0,
                                      icon: Icon(
                                          SocialMediaIcons.twitter_squared,
                                          color: Color.fromRGBO(
                                              108, 173, 222, 1.0)),
                                      onPressed: null)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          } else {
            return Text('loading...');
          }
        });
  }
}
