import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String fname = '';
  String lname = '';
  String email = '';
  String username = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(8.0, 50.0, 0.0, 0.0),
                      child: Text('Sign Up',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 15.0, left: 40.0, right: 40.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    TextFormField(
                      onEditingComplete: () => node.nextFocus(),
                      onChanged: (val) {
                        setState(() => fname = val);
                        print(fname);
                      },
                      decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Firstname cannot be null';
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      onEditingComplete: () => node.nextFocus(),
                      onChanged: (val) {
                        setState(() => lname = val);
                        print(lname);
                      },
                      decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Lastname cannot be null';
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      onEditingComplete: () => node.nextFocus(),
                      onChanged: (val) {
                        setState(() => username = val);
                        print(username);
                      },
                      decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Username cannot be null';
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      onEditingComplete: () => node.nextFocus(),
                      onChanged: (val) {
                        setState(() => email = val);
                        print(email);
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Email cannot be null';
                        else if (!value.contains("@"))
                          return "Invalid Email";
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      onEditingComplete: () => node.nextFocus(),
                      onChanged: (val) {
                        setState(() => password = val);
                        print(password);
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password cannot be null';
                        }
                        return null;
                      },
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  email, password, fname, lname, username);
                          print(result);
                          if (result.runtimeType != FirebaseUser) {
                            setState(() {
                              error = result.message.toString();
                            });
                          }
                        }
                      },
                      child: Text('Sign Up'),
                    ),
                    SizedBox(width: 5),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Back'),
                    ),
                  ]),
                )),
          ],
        ));
  }
}
