import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

bool beAnonymous = false;
String userID = 'Rco0ZMq21weyKLtdNtTSiemBV6K2';
String title = 'testTitle';
String description = 'testDescription';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  group('CRUD Prayer Requests :', () {
    test('Add a prayer request', () {
      expect(database.addPrayerRequest(userID, beAnonymous, title, description),
          isInstanceOf<Future>());
    });
  });
}
