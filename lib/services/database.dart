import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps/gps.dart';
import 'package:CrimsonMinistry/models/event.dart';

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
    return await userCollection.document(uid).setData({
      'firstName': fname,
      'lastName': lname,
      'username': username,
      'email': email
    });
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

  Stream<List<Event>> get events {
    return eventCollection.snapshots().map(_eventListFromSnapshot);
  }

  Stream<QuerySnapshot> get prayers {
    return prayerCollection.snapshots();
  }
}
