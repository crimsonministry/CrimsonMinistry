import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

String documentID = 'SKE66wWLXZogiazW53NH';
String title = 'Bible Study at the Quad';
String location = 'In front of Denny Chimes';
String description = 'Updated description!';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('Update an event', () async {
    expect(database.updateEvent(documentID, title, location, description),
        isInstanceOf<Future>());
  });
}
