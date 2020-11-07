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

    TextEditingController title =
        new TextEditingController(text: widget.prayer.title);
    TextEditingController description =
        new TextEditingController(text: widget.prayer.description);

    return new Scaffold(
        appBar: AppBar(
          title: Text("Edit Prayer"),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: title,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    controller: description,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(height: 50.0),
                  RaisedButton(
                    onPressed: () async {
                      _data.deletePrayer(widget.prayer.id);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      showDeletedDialog(context);
                      // call function in database to update the changes
                    },
                    child: const Text('Delete', style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    onPressed: () async {
                      _data.updatePrayer(
                          widget.prayer.id, title.text, description.text);
                      print(title.text);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      showAlertDialog(context);
                      // call function in database to update the changes
                    },
                    child: const Text('Submit', style: TextStyle(fontSize: 20)),
                  ),
                ],
              )),
        ]));
  }
}
