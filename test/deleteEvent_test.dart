import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

String documentID = 'SKE66wWLXZogiazW53NH';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('Delete an event', () async {
    expect(database.deleteEvent(documentID), isInstanceOf<Future>());
  });
}
