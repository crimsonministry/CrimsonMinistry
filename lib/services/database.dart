import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps/gps.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
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

  final CollectionReference postCollection =
      Firestore.instance.collection('posts');

  Future updatePostData(String userId, GpsLatlng coordinates, Timestamp time,
      String title, String eventType, String description) async {
    return await postCollection.document(uid).setData({
      'userID': userId,
      'location': coordinates,
      'time:': time,
      'title': title,
      'eventType': eventType,
      'description': description
    });
  }
}
