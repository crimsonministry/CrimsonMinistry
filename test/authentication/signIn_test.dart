import 'package:flutter_test/flutter_test.dart';
import 'package:CrimsonMinistry/services/auth.dart';

String email = 'namito24yokota@gmail.com';
String password = 'NamitoYokota';

void main() {
  final AuthService auth = AuthService();
  test('Sign In', () {
    expect(auth.signInWithEmailAndPassword(email, password),
        isInstanceOf<Future>());
  });
}
