import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/auth.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/screens/account/account.dart';
import 'package:CrimsonMinistry/screens/account/events/events.dart';
import 'package:CrimsonMinistry/screens/account/prayers/prayers.dart';
import 'package:CrimsonMinistry/screens/account/favorites/favorites.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return new Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text('Avatar'),
                          radius: 50.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${userData.fname} ${userData.lname}',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight + Alignment(0, .3),
                        child: Text(
                          '@${userData.username}',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ]),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                  ListTile(
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Account(userAccountId: userData.uid),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Events'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyEvents(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Prayer Requests'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPrayers(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Friends'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyFriends(),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Sign Out'),
                    onTap: () async {
                      dynamic result = await _auth.signOut();
                    },
                  ),
                ],
              ),
            );
          } else {
            return Text('loading');
          }
        });
  }
}
