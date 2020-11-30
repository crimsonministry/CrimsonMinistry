import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/database.dart';

String documentID = 'AcGYXKfek2glQO97gIYW';
String userID = 'c19Ohkzp6PdpIRGriC0Jpzv4Rd22';
List<String> myprayed = ['AcGYXKfek2glQO97gIYW'];
List<String> prayed = ['c19Ohkzp6PdpIRGriC0Jpzv4Rd22'];

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService database = DatabaseService();
  test('Pray for Prayer Request', () async {
    expect(database.addToRSVP(userID, myprayed, documentID, prayed),
        isInstanceOf<Future>());
  });
}
