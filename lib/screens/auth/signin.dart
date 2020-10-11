import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';
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
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (val) {
                        setState(() => email = val);
                        print(email);
                      },
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      onChanged: (val) {
                        setState(() => password = val);
                        print(password);
                      },
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                      obscureText: true,
                    ),
                    SizedBox(height: 40.0),
                    RaisedButton(
                      onPressed: () async {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        print(result);
                      },
                      child:
                          const Text('Log In', style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.grey,
                        color: Colors.red,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/signup');
                          },
                          child: Center(
                            child: Text(
                              'CREATE PROFILE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}

// code cited: https://github.com/rajayogan/flutter-minimalloginUI/blob/master/lib/main.dart
