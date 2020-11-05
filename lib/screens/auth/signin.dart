import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignUpPage()
      },
      home: new SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInState createState() => new _SignInState();
}

class _SignInState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
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
                      padding: EdgeInsets.fromLTRB(8.0, 110.0, 0.0, 0.0),
                      child: Text('Crimson',
                          style: TextStyle(
                              fontSize: 70.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))),
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 175.0, 0.0, 0.0),
                    child: Text('Ministry',
                        style: TextStyle(
                            fontSize: 71.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 40.0, right: 40.0),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      TextFormField(
                        onEditingComplete: () => node.nextFocus(),
                        onChanged: (val) {
                          setState(() => email = val);
                          print(email);
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Email cannot be null';
                          else if (!value.contains("@"))
                            return "Invalid email";
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
                            labelText: 'Passowrd',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () async {
                                // Validate returns true if the form is valid, otherwise false.
                                if (_formKey.currentState.validate()) {
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  print(result);
                                  if (result.runtimeType != FirebaseUser) {
                                    setState(() {
                                      error = result.message.toString();
                                    });
                                  }
                                }
                              },
                              child: Text('Sign In'),
                            ),
                            SizedBox(width: 5),
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/signup');
                              },
                              child: Text('Sign Up'),
                            ),
                          ]),
                    ]))),
          ],
        ));
  }
}
