import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';
import 'package:CrimsonMinistry/models/prayer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('Read prayers list', () {
    expect(database.prayers, isInstanceOf<Stream<List<Prayer>>>());
  });
}
