import 'package:flutter/material.dart';

class RSVPTile extends StatelessWidget {
  final String userID;
  RSVPTile({this.userID});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Colors.blueGrey[900],
            size: 40,
          ),
          title: Text('fname lname'),
          subtitle: Text(userID),
          trailing: Icon(Icons.more_vert),
          isThreeLine: true,
          onTap: () {
            // view user profile
            print('view user profile (to be implemented)');
          }),
    );
  }
}
