import 'package:CrimsonMinistry/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:CrimsonMinistry/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // listen to auth change
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      return error;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password,
      String fname, String lname, String username) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // create a new document for the new user in the database
      await DatabaseService(uid: user.uid)
          .updateUserData(fname, lname, username, email);

      return user;
    } catch (error) {
      return error;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      return null;
    }
  }

  // delete account
  Future deleteUser(String email, String password) async {
    try {
      FirebaseUser user = await _auth.currentUser();
      AuthCredential credentials =
          EmailAuthProvider.getCredential(email: email, password: password);
      AuthResult result = await user.reauthenticateWithCredential(credentials);
      await DatabaseService(uid: result.user.uid).deleteUser();
      await result.user.delete();
      return true;
    } catch (error) {
      return error;
    }
  }
}
