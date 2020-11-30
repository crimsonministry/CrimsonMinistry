import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';

class RSVPTile extends StatefulWidget {
  final String userID;
  RSVPTile({this.userID});

  @override
  _RSVPTileState createState() => _RSVPTileState();
}

class _RSVPTileState extends State<RSVPTile> {
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
            // view user profile
            print('view user profile (to be implemented)');
          }),
    );
  }
}
