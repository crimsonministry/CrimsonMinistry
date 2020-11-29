import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

String documentID = 'YjEFKLBx7orppML0x7d0';
String userID = 'c19Ohkzp6PdpIRGriC0Jpzv4Rd22';
List<String> myrsvp = ['YjEFKLBx7orppML0x7d0'];
List<String> rsvp = ['c19Ohkzp6PdpIRGriC0Jpzv4Rd22'];

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('RSVP to Event', () async {
    expect(database.addToRSVP(userID, myrsvp, documentID, rsvp),
        isInstanceOf<Future>());
  });
}
