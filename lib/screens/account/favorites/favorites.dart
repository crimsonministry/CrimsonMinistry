import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/screens/account/favorites/searchfriend.dart';
import 'favoriteslist.dart';

class MyFriends extends StatefulWidget {
  @override
  _MyFriendsPageState createState() => _MyFriendsPageState();
}

class _MyFriendsPageState extends State<MyFriends> {
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  title: Text("Favorited Users"),
                  backgroundColor: Colors.red,
                  actions: <Widget>[
                    FlatButton(
                      textColor: Colors.white,
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchFriendPage(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.add,
                        size: 26.0,
                      ),
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.transparent)),
                    ),
                  ],
                ),
                resizeToAvoidBottomPadding: false,
                body: FavoritesList(userData.favoritesList));
          } else {
            return Text('loading...');
          }
        });
  }
}
