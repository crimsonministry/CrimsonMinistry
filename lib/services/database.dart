import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps/gps.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference eventCollection =
      Firestore.instance.collection('events');
  final CollectionReference prayerCollection =
      Firestore.instance.collection('prayers');

  Future updateUserData(
      String fname, String lname, String username, String email) async {
    List<String> empty = [];
    return await userCollection.document(uid).setData({
      'firstName': fname,
      'lastName': lname,
      'username': username,
      'email': email,
      'biography': '',
      'ministry': '',
      'friends': empty,
      'requests': empty,
      'requested': empty,
    });
  }

  Future updateAccountPageData(String userID, String fname, String lname,
      String username, String ministry, String bio) async {
    return await userCollection.document(userID).updateData({
      'firstName': fname,
      'lastName': lname,
      'username': username,
      'ministry': ministry,
      'biography': bio
    });
  }

  Future sendFriendRequest(String userID, List<String> requests) async {
    // add to your own 'requests' list
    return await userCollection
        .document(userID)
        .updateData({'requests': requests});

    // add to their 'requested' list
    // add friendID or username as parameter at the top
    // if username
    // get the friendID
    // then get user from friendID and add your id to their requested list
    // if friendID
    // add your ID to their requested list
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      fname: snapshot.data['firstName'],
      lname: snapshot.data['lastName'],
      username: snapshot.data['username'],
      bio: snapshot.data['biography'],
      ministry: snapshot.data['ministry'],
      friends: List<String>.from(snapshot.data['friends']) ?? '',
      requests: List<String>.from(snapshot.data['requests']) ?? '',
      requested: List<String>.from(snapshot.data['requested']) ?? '',
    );
  }

  Future addEvent(String userid, DateTime date, String typeOfEvent,
      String title, String location, String description) async {
    List<String> rsvp = [userid];
    return await eventCollection.document(uid).setData({
      'eventType': typeOfEvent,
      'datetime': Timestamp.fromDate(date),
      'title': title,
      'location': location,
      'description': description,
      'rsvp': rsvp,
      'createdAt': Timestamp.now(),
      'userID': userid,
    });
  }

  Future updateEvent(String id, String title, String time, String location,
      String typeOfEvent, String description) async {
    print('updated event!');
    return await eventCollection.document(id).updateData({
      'title': title,
      'location': location,
      'time': time,
      'eventType': typeOfEvent,
      'description': description,
    });
  }

  Future deleteEvent(String id) async {
    print('deleted event!');
    return await eventCollection.document(id).delete();
  }

  Future addToRSVP(String documentID, List<String> rsvp) async {
    return await eventCollection.document(documentID).updateData({
      'rsvp': rsvp,
    });
  }

  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Event(
        id: doc.documentID,
        title: doc.data['title'] ?? '',
        location: doc.data['location'] ?? '',
        time: doc.data['time'] ?? '',
        typeOfEvent: doc.data['eventType'] ?? '',
        description: doc.data['description'] ?? '',
        rsvp: List<String>.from(doc.data['rsvp']) ?? '',
        userID: doc.data['userID'] ?? '',
      );
    }).toList();
  }

  Future updatePrayerData(String title, String description) async {
    return await prayerCollection.document(uid).setData({
      'title': title,
      'description': description,
      'count': 0,
    });
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<Event>> get events {
    return eventCollection.snapshots().map(_eventListFromSnapshot);
  }

  Stream<QuerySnapshot> get prayers {
    return prayerCollection.snapshots();
  }
}
