import 'package:CrimsonMinistry/screens/account/friends/searchfriend.dart';
import 'package:flutter/material.dart';
import 'addfriend.dart';

class MyFriends extends StatefulWidget {
  @override
  _MyFriendsPageState createState() => _MyFriendsPageState();
}

class _MyFriendsPageState extends State<MyFriends> {
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("My Friends"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder: (context) => AddFriendPage(),
                    builder: (context) => SearchFriendPage(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                size: 26.0,
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          // to be added
        ]));
  }
}
