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

  showErrorDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("You have already sent a friend request to this user"),
    );

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
                body: Column(children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          RaisedButton(
                            onPressed: () async {
                              print('trying to send friend request');
                              if (userData.favoritesList
                                  .contains(widget.username)) {
                                print(
                                    'show error: you have sent a request to this person already');
                                showErrorDialog(context);
                              } else {
                                userData.favoritesList.add(widget.username);
                                await _data.sendFriendRequest(
                                    user.uid, userData.favoritesList);
                              }
                              print(userData.favoritesList);
                              showAlertDialog(context);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text('Send Request to @${widget.username}',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      )),
                ]));
          } else {
            return Text('loading');
          }
        });
  }
}
