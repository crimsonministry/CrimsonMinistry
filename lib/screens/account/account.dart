import 'package:CrimsonMinistry/screens/account/friends/addfriend.dart';
import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/screens/account/edit.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_icons.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatefulWidget {
  final String userAccountId;

  Account({this.userAccountId});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<Account> {
  final DatabaseService _data = DatabaseService();

  showSocialMediaPage(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Sorry, this user does not have that social media :("),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  FlatButton showFavoriteButton(
      BuildContext context, User currentUser, UserData userData) {
    if (widget.userAccountId == currentUser.uid) {
      return FlatButton(
          textColor: Colors.white,
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAccount(
                    userData: userData,
                  ),
                ));
          },
          child: Text(
            "Edit",
            textScaleFactor: 1.5,
            style: new TextStyle(fontSize: 12.0, color: Colors.white),
          ));
    } else {
      return FlatButton(
          textColor: Colors.white,
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddFriendPage(username: userData.username)));
          },
          child: Text(
            "Favorite",
            textScaleFactor: 1.5,
            style: new TextStyle(fontSize: 12.0, color: Colors.white),
          ));
    }
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: widget.userAccountId).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return new Scaffold(
                appBar: AppBar(
                  title: Text("Account"),
                  backgroundColor: Colors.red,
                  actions: <Widget>[
                    showFavoriteButton(context, user, userData)
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
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  (userData.facebook.isNotEmpty)
                                      ? IconButton(
                                          iconSize: 32.0,
                                          icon: Icon(
                                            SocialMediaIcons.facebook_squared,
                                            color: Color.fromRGBO(
                                                66, 103, 178, 1.0),
                                          ),
                                          onPressed: () => showSocialMediaPage(
                                              userData.facebook))
                                      : Text(''),
                                  (userData.instagram.isNotEmpty)
                                      ? IconButton(
                                          iconSize: 32.0,
                                          icon: Icon(SocialMediaIcons.instagram,
                                              color: Color.fromRGBO(
                                                  225, 48, 108, 1.0)),
                                          onPressed: () => showSocialMediaPage(
                                              userData.instagram))
                                      : Text(''),
                                  (userData.twitter.isNotEmpty)
                                      ? IconButton(
                                          iconSize: 32.0,
                                          icon: Icon(
                                              SocialMediaIcons.twitter_squared,
                                              color: Color.fromRGBO(
                                                  108, 173, 222, 1.0)),
                                          onPressed: () => showSocialMediaPage(
                                              userData.twitter),
                                        )
                                      : Text(''),
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
