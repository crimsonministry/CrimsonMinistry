import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

String documentID = 'KegTfbsJbcwm8WRXxHan';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('Delete a prayer', () async {
    expect(database.deletePrayer(documentID), isInstanceOf<Future>());
  });
}
