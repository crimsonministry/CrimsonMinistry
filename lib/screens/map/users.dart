import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'view.dart';

class GetUsers extends StatefulWidget {
  @override
  _GetUsersState createState() => _GetUsersState();
}

class _GetUsersState extends State<GetUsers> {
  List<UserData> users = List<UserData>();
  @override
  Widget build(BuildContext context) {
    users = Provider.of<List<UserData>>(context) ?? [];

    return StreamProvider<List<Event>>.value(
      value: DatabaseService().events,
      child: MapView(users: users),
    );
  }
}
