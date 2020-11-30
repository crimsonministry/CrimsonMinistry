import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';

class AddFriendPage extends StatefulWidget {
  final String username;

  AddFriendPage({this.username});
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final DatabaseService _data = DatabaseService();

  showAlertDialog(BuildContext context, bool added) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: (added) ? Text("Favorited User") : Text("Unfavorited User"),
      content: Text("${widget.username}"),
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
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return new Scaffold(
              appBar: AppBar(
                title: Text("Confirm Friend"),
                backgroundColor: Colors.red,
              ),
              resizeToAvoidBottomPadding: false,
              body: Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: (userData.favoritesList.contains(widget.username))
                      ? RaisedButton(
                          onPressed: () async {
                            userData.favoritesList.remove(widget.username);
                            await _data.favoriteUser(
                                user.uid, userData.favoritesList);
                            print(userData.favoritesList);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            showAlertDialog(context, false);
                          },
                          child: Text('Unfavorite @${widget.username}',
                              style: TextStyle(fontSize: 20)),
                        )
                      : RaisedButton(
                          onPressed: () async {
                            userData.favoritesList.add(widget.username);
                            await _data.favoriteUser(
                                user.uid, userData.favoritesList);
                            print(userData.favoritesList);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            showAlertDialog(context, true);
                          },
                          child: Text('Favorite @${widget.username}',
                              style: TextStyle(fontSize: 20)),
                        )),
            );
          } else {
            return Text('loading');
          }
        });
  }
}
