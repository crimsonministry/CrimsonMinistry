import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/prefer_universal/js.dart';

class SearchFriendPage extends StatefulWidget {
  @override
  _SearchFriendPageState createState() => _SearchFriendPageState();
}

class _SearchFriendPageState extends State<SearchFriendPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;
  final DatabaseService _data = DatabaseService();

  clearTheTextFormField() {
    searchTextEditingController.clear();
  }

  searchForUser(String searchUserName) {
    Future<QuerySnapshot> allUsers = _data.userCollection
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
        onFieldSubmitted: searchForUser,
      ),
    );
  }
}

Container noResultDisplay() {
  final Orientation orientation = MediaQuery.of(context).orientation;
  return Container(
    child: Center(child: ListView(shrinkWrap: true, children: <Widget>[
      Icon(Icons.group, color: Colors.grey, size: 200.0,),
      Text("No Users Found :(",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 60.0,
      ),
      ),
    ],
    ),
    ),
    );
}

resultFoundDisplay() {
  return FutureBuilder(
    future: futureSearchResults,
    builder: (context, dataSnapshot) {
      if(!dataSnapshot.hasData) {
        return circularProgress();
      }

      List<UserResults> searchUsersResult = [];
      dataSnapshot.data.documents.forEach((document){
        User eachUser = User.fromDocument(document);
        UserResults userResults = UserResults(eachUser);
        searchUsersResult.add(userResults);
      });

      return ListView(children: searchUsersResult);

    },
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchFriendPageHeader(),
      body: futureSearchResults == null ? noResultDisplay() : resultFoundDisplay(),

    );
  }
}

class UserResults extends StatelessWidget {
  final User eachUser;
  UserResults(this.eachUser);



  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(4.0),
    child: Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => print("tapped"),
            child: ListTile(
              title: Text(
                eachUser.uid,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              subtitle: Text("@username",
              style: TextStyle(color: Colors.black, fontSize: 13.0,),
            ),
          )
        ],)
    ),
    );
  }
}
