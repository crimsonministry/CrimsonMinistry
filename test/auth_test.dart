import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/auth.dart';

String email = 'test@email.com';
String password = 'testPassword';
String fname = 'testFirstName';
String lname = 'testLastName';
String username = 'testUsername';

void main() {
  final AuthService auth = AuthService();
  group('Authentication :', () {
    test('Register with Email and Password', () {
      expect(
          auth.registerWithEmailAndPassword(
              email, password, fname, lname, username),
          isInstanceOf<Future>());
    });

    test('SignIn with Email and Password', () {
      expect(auth.signInWithEmailAndPassword(email, password),
          isInstanceOf<Future>());
    });
  });
}
