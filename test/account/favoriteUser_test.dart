import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

String userID = 'c19Ohkzp6PdpIRGriC0Jpzv4Rd22';
List<String> favorites = ['4rznagGj55cw17pIoH9sCjLUfL63'];

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('Favorite User', () async {
    expect(database.favoriteUser(userID, favorites), isInstanceOf<Future>());
  });
}
