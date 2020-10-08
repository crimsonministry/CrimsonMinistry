import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';
import 'package:CrimsonMinistry/services/database.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();
  String fname = '';
  String lname = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50.0),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (val) {
                          setState(() => fname = val);
                          print(fname);
                        },
                        decoration: InputDecoration(
                            labelText: 'FIRST NAME',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        onChanged: (val) {
                          setState(() => lname = val);
                          print(lname);
                        },
                        decoration: InputDecoration(
                            labelText: 'LAST NAME',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                      TextField(
                        onChanged: (val) {
                          setState(() => email = val);
                          print(email);
                        },
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        onChanged: (val) {
                          setState(() => password = val);
                          print(password);
                        },
                        decoration: InputDecoration(
                            labelText: 'PASSWORD ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                        obscureText: true,
                      ),
                      SizedBox(height: 50.0),
                      RaisedButton(
                        onPressed: () async {
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  email, password, fname, lname);
                          print(result);
                        },
                        child: const Text('Sign Up',
                            style: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text('GO BACK',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ]));
  }
}

// code cited: https://github.com/rajayogan/flutter-minimalloginUI/blob/master/lib/signup.dart
