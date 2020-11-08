import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'package:CrimsonMinistry/services/database.dart';

class EditPrayerPage extends StatefulWidget {
  @override
  final Prayer prayer;
  EditPrayerPage({Key key, @required this.prayer}) : super(key: key);
  _EditPrayerPageState createState() => _EditPrayerPageState();
}

class _EditPrayerPageState extends State<EditPrayerPage> {
  final DatabaseService _data = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Prayer edited!"),
      content: Text("Thanks for the update :))"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDeletedDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Prayer deleted!"),
      content: Text("Thanks for the update :))"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    final node = FocusScope.of(context);

    TextEditingController title =
        new TextEditingController(text: widget.prayer.title);
    TextEditingController description =
        new TextEditingController(text: widget.prayer.description);
    ;

    return new Scaffold(
        appBar: AppBar(
          title: Text("Edit Prayer"),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 30.0, left: 40.0, right: 40.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onEditingComplete: () => node.nextFocus(),
                        controller: title,
                        decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Title cannot be null';
                          else
                            return null;
                        },
                      ),
                      TextFormField(
                        onEditingComplete: () => node.nextFocus(),
                        controller: description,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          await _data.deletePrayer(widget.prayer.id);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          showDeletedDialog(context);
                        },
                        child: Text('Delete Prayer'),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await _data.updatePrayer(
                                widget.prayer.id, title.text, description.text);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            showAlertDialog(context);
                          }
                        },
                        child: Text('Submit Changes'),
                      ),
                    ],
                  ))),
        ]));
  }
}
