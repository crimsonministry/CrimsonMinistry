import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps/gps.dart';
import 'package:CrimsonMinistry/models/event.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // User data collection
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future updateUserData(
      String fname, String lname, String username, String email) async {
    return await userCollection.document(uid).setData({
      'firstName': fname,
      'lastName': lname,
      'username': username,
      'email': email
    });
  }

  // Post data collection
  final CollectionReference postCollection =
      Firestore.instance.collection('events');

  Future updatePostData(String userid, String location, String time,
      String title, String eventType, String description) async {
    var rsvp = List.filled(1, userid, growable: true);
    print(rsvp);
    return await postCollection.document(uid).setData({
      'location': location,
      'time': time,
      'title': title,
      'eventType': eventType,
      'description': description,
      'userID': userid,
      'rsvp': rsvp
    });
  }

  final CollectionReference eventCollection =
      Firestore.instance.collection('events');

  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Event(
          title: doc.data['title'] ?? '',
          location: doc.data['location'] ?? '',
          time: doc.data['time'] ?? '',
          typeOfEvent: doc.data['typeOfEvent'] ?? '',
          description: doc.data['description'] ?? '');
    }).toList();
  }

  Stream<List<Event>> get events {
    return eventCollection.snapshots().map(_eventListFromSnapshot);
  }

  // Prayer data collection
  final CollectionReference prayerCollection =
      Firestore.instance.collection('prayers');

  Future updatePrayerData(String title, String description) async {
    return await prayerCollection.document(uid).setData({
      'title': title,
      'description': description,
      'count': 0,
    });
  }

  // Get the prayer collection of data
  Stream<QuerySnapshot> get prayers {
    return prayerCollection.snapshots();
  }
}
