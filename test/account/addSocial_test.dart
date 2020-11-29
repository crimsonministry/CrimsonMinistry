import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

String userID = 'c19Ohkzp6PdpIRGriC0Jpzv4Rd22';
String fname = 'Namito';
String lname = 'Yokota';
String username = 'namitoyokota';
String ministry = 'Reach';
String bio = 'Bio';
String twitter = 'https://twitter.com/namitoyokota';
String facebook = 'https://facebook.com/namitoyokota';
String insta = 'https://instagram.com/namito_yokota';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('Add Social Media', () async {
    expect(
        database.updateAccountPageData(userID, fname, lname, username, ministry,
            bio, twitter, facebook, insta),
        isInstanceOf<Future>());
  });
}
