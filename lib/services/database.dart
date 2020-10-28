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
      'friends': empty,
      'requests': empty,
      'requested': empty,
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
      fname: snapshot.data['fname'],
      lname: snapshot.data['lname'],
      username: snapshot.data['username'],
      friends: List<String>.from(snapshot.data['friends']) ?? '',
      requests: List<String>.from(snapshot.data['requests']) ?? '',
      requested: List<String>.from(snapshot.data['requested']) ?? '',
    );
  }

  Future updatePostData(String userid, String location, String time,
      String title, String eventType, String description) async {
    List<String> rsvp = [userid];
    return await eventCollection.document(uid).setData({
      'location': location,
      'time': time,
      'title': title,
      'eventType': eventType,
      'description': description,
      'rsvp': rsvp,
      'userID': userid,
    });
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
        typeOfEvent: doc.data['typeOfEvent'] ?? '',
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
