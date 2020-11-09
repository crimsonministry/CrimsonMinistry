import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

String documentID = 'KegTfbsJbcwm8WRXxHan';
String title = 'testTitle';
String description = 'testDescription';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('Update a prayer request', () {
    expect(database.updatePrayer(documentID, title, description),
        isInstanceOf<Future>());
  });
}
