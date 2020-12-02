import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/screens/account/account.dart';

class PrayedTile extends StatefulWidget {
  final String userID;
  PrayedTile({this.userID});

  @override
  _PrayedTileState createState() => _PrayedTileState();
}

class _PrayedTileState extends State<PrayedTile> {
  List<UserData> users = List<UserData>();

  @override
  Widget build(BuildContext context) {
    users = Provider.of<List<UserData>>(context) ?? [];
    int userIndex = users.indexWhere((user) => user.uid == widget.userID);
    UserData user = users[userIndex];

    return Card(
      child: ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Colors.blueGrey[900],
            size: 40,
          ),
          title: Text('${user.fname} ${user.lname}'),
          subtitle: Text(user.username),
          trailing: Icon(Icons.more_vert),
          isThreeLine: true,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Account(userAccountId: user.uid)));
          }),
    );
  }
}

