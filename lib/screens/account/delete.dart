import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/services/auth.dart';

class DeleteAccountPage extends StatefulWidget {
  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return new Scaffold(
      appBar: AppBar(
        title: Text('Delete Account'),
        backgroundColor: Colors.red,
      ),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 30.0),
                    child: Text('Account Verification',
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
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'email cannot be null';
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Password cannot be null';
                      else
                        return null;
                    },
                  ),
                  Text(error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0)),
                  RaisedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid
                      if (_formKey.currentState.validate()) {
                        dynamic result =
                            await _auth.deleteUser(email, password);
                        if (result != true) {
                          setState(() {
                            error = result.message.toString();
                          });
                        }
                      }
                    },
                    child: const Text('Confirm Account Deletion',
                        style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
