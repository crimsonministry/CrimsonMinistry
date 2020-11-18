import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:CrimsonMinistry/models/event.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
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
    print('creating user data');
    print('firstName : $fname');
    print('lastName : $lname');
    print('username : $username');
    print('email : $email');
    print('success');

    List<String> empty = [];
    return await userCollection.document(uid).setData({
      'firstName': fname,
      'lastName': lname,
      'username': username,
      'email': email,
      'biography': '',
      'ministry': '',
      'favorites': empty,
      'rsvped': empty,
      'prayed': empty,
      'twitterLink': '',
      'facebookLink': '',
      'instaLink': ''
    });
  }

  Future updateAccountPageData(
      String userID,
      String fname,
      String lname,
      String username,
      String ministry,
      String bio,
      String twitter,
      String facebook,
      String insta) async {
    print('updating account');
    print('userID : $userID');
    print('firstName : $fname');
    print('lastName : $lname');
    print('username : $username');
    print('ministry : $ministry');
    print('bio : $bio');
    print('twitterLink : $twitter');
    print('facebookLink : $facebook');
    print('instaLink : $insta');
    print('success');

    return await userCollection.document(userID).updateData({
      'firstName': fname,
      'lastName': lname,
      'username': username,
      'ministry': ministry,
      'biography': bio,
      'twitterLink': twitter,
      'facebookLink': facebook,
      'instaLink': insta
    });
  }

  Future sendFriendRequest(String userID, List<String> requests) async {
    print('sending friend request');
    print('userID : $userID');
    print('success');

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
        favoritesList: List<String>.from(snapshot.data['favorites']) ?? '',
        rsvpedList: List<String>.from(snapshot.data['rsvped']) ?? '',
        prayedList: List<String>.from(snapshot.data['prayed']) ?? '',
        twitter: snapshot.data['twitterLink'],
        facebook: snapshot.data['facebookLink'],
        instagram: snapshot.data['instaLink']);
  }

  Future deleteUser() async {
    print('deleting user');
    print('userID : $uid');
    print('success');

    return await userCollection.document(uid).delete();
  }

  Future addEvent(String userid, DateTime date, String typeOfEvent,
      String title, GeoPoint location, String description) async {
    print('adding event');
    print('userID : $userid');
    print('date : ${date.toString()}');
    print('typeOfEvent : $typeOfEvent');
    print('title : $title');
    print('location : $location');
    print('description : $description');
    print('success');

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

  Future updateEvent(
      String id, String title, String location, String description) async {
    print('updating event');
    print('documentID : $id');
    print('title : $title');
    print('location : $location');
    print('description : $description');
    print('success');

    return await eventCollection.document(id).updateData({
      'title': title,
      'location': location,
      'description': description,
    });
  }

  Future deleteEvent(String id) async {
    print('deleting event');
    print('documentID : $id');
    print('success');

    return await eventCollection.document(id).delete();
  }

  Future addToRSVP(String userID, List<String> myrsvp, String documentID,
      List<String> rsvp) async {
    print('adding to rsvp');
    print('documentID : $documentID');
    print('rsvpList : $rsvp');
    print('success');

    await userCollection.document(userID).updateData({
      'rsvped': myrsvp,
    });

    return await eventCollection.document(documentID).updateData({
      'rsvp': rsvp,
    });
  }

  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Event(
        id: doc.documentID,
        title: doc.data['title'] ?? '',
        location: doc.data['location'] ?? new GeoPoint(33.2140, -87.5391),
        dateTime: doc.data['datetime']?.toDate() ?? Timestamp.now().toDate(),
        typeOfEvent: doc.data['eventType'] ?? '',
        description: doc.data['description'] ?? '',
        rsvp: List<String>.from(doc.data['rsvp']) ?? '',
        userID: doc.data['userID'] ?? '',
      );
    }).toList();
  }

  Future addPrayerRequest(
      String userid, bool anonymous, String title, String description) async {
    print('adding prayer');
    print('userID : $userid');
    print('anonymous : $anonymous');
    print('title : $title');
    print('description : $description');
    print('success');

    List<String> prayerInteractions = [];
    return await prayerCollection.document(uid).setData({
      'anonymous': anonymous,
      'title': title,
      'description': description,
      'prayerInteractions': prayerInteractions,
      'createdAt': Timestamp.now(),
      'userID': userid,
    });
  }

  Future updatePrayer(String id, String title, String description) async {
    print('updating prayer');
    print('documentID : $id');
    print('title : $title');
    print('description : $description');
    print('success');

    return await prayerCollection.document(id).updateData({
      'title': title,
      'description': description,
    });
  }

  Future deletePrayer(String id) async {
    print('deleting prayer');
    print('documentID : $id');
    print('success');

    return await prayerCollection.document(id).delete();
  }

  List<Prayer> _prayerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Prayer(
        id: doc.documentID,
        anonymous: doc.data['anonymous'] ?? true,
        title: doc.data['title'] ?? '',
        description: doc.data['description'] ?? '',
        prayerInteractions:
            List<String>.from(doc.data['prayerInteractions']) ?? '',
        userID: doc.data['userID'] ?? '',
      );
    }).toList();
  }

  Future addToPrayerInteractions(String userID, List<String> myprayed,
      String documentID, List<String> prayerInteractions) async {
    print('added to prayerInteractions');

    await userCollection.document(userID).updateData({
      'prayed': myprayed,
    });

    return await prayerCollection.document(documentID).updateData({
      'prayerInteractions': prayerInteractions,
    });
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<Event>> get events {
    print('reading events');
    print('success');
    return eventCollection.snapshots().map(_eventListFromSnapshot);
  }

  Stream<List<Prayer>> get prayers {
    print('reading prayers');
    print('success');
    return prayerCollection.snapshots().map(_prayerListFromSnapshot);
  }
}
