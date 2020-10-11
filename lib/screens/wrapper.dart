import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/screens/home/home.dart';
import 'package:CrimsonMinistry/screens/auth/signin.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return home or authentication as needed
    final user = Provider.of<User>(context);
    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
