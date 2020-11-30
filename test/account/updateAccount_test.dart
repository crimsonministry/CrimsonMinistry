import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

String userID = 'c19Ohkzp6PdpIRGriC0Jpzv4Rd22';
String fname = 'newFname';
String lname = 'newLname';
String username = 'newUsername';
String ministry = 'newMinistry';
String bio = 'newBio';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('Update Account Information', () async {
    expect(
        database.updateAccountPageData(
            userID, fname, lname, username, ministry, bio, '', '', ''),
        isInstanceOf<Future>());
  });
}
