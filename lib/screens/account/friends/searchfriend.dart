import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';

class SearchFriendPage extends StatefulWidget {
  @override
  _SearchFriendPageState createState() => _SearchFriendPageState();
}

class _SearchFriendPageState extends State<SearchFriendPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;

  clearTheTextFormField() {
    searchTextEditingController.clear();
  }

  searchForUser(String searchUserName) {
    Future<QuerySnapshot> allUsers = userC
        .where("username", isGreaterThanOrEqualTo: searchUserName)
        .getDocuments();
    setState(() {
      futureSearchResults = allUsers;
    });
  }

  AppBar searchFriendPageHeader() {
    return AppBar(
      backgroundColor: Colors.red,
      title: TextFormField(
        style: TextStyle(fontSize: 18.0, color: Colors.white),
        controller: searchTextEditingController,
        decoration: InputDecoration(
            hintText: "Search Friends here...",
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            filled: true,
            prefixIcon: Icon(Icons.person_pin, color: Colors.white, size: 30.0),
            suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
                onPressed: clearTheTextFormField())),
        onFieldSubmitted: searchForUser(),
      ),
    );
  }
}

class _SearchFriendPageState extends State<SearchFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchFriendPageHeader(),
    );
  }
}

class UserResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("User Results");
  }
}
