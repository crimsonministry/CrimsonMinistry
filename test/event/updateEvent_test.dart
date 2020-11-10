import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

String documentID = 'SKE66wWLXZogiazW53NH';
String title = 'Bible Study at the Quad';
String location = 'In front of Denny Chimes';
String description = 'My friend and I are going through Chapter 1 of Matthew';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('Update an event', () async {
    expect(database.updateEvent(documentID, title, location, description),
        isInstanceOf<Future>());
  });
}
