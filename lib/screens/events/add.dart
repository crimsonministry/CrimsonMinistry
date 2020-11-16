import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/services/database.dart';

class AddEventPage extends StatefulWidget {
  @override
  final LatLng point;
  AddEventPage({Key key, @required this.point}) : super(key: key);
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final DatabaseService _data = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  DateTime pickedDate;
  TimeOfDay time;
  String typeOfEvent = '';
  String title = '';
  String location = '';
  String description = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Event added!"),
      content: Text("Thanks for your submission :))"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );

    if (date != null)
      setState(() {
        pickedDate = new DateTime(
            date.year, date.month, date.day, time.hour, time.minute);
      });
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: time);

    if (t != null)
      setState(() {
        pickedDate = new DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, t.hour, t.minute);
      });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    final node = FocusScope.of(context);
    return new Scaffold(
        appBar: AppBar(
          title: Text("Create Event"),
          backgroundColor: Colors.red,
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 30.0, left: 40.0, right: 40.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                    child: Text('Date and Time',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlineButton(
                          child: Text(
                              "${pickedDate.month} / ${pickedDate.day} / ${pickedDate.year}"),
                          onPressed: _pickDate,
                        ),
                        SizedBox(width: 5),
                        OutlineButton(
                          child:
                              Text("${pickedDate.hour}:${pickedDate.minute}"),
                          onPressed: _pickTime,
                        ),
                      ]),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    items: <String>[
                      'Mission',
                      'Bible Study',
                      'Worship',
                      'Volunteer'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => typeOfEvent = val);
                      print(typeOfEvent);
                    },
                    decoration: InputDecoration(
                        labelText: 'Type',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    validator: (value) {
                      if (value == null)
                        return 'Event type cannot be null';
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: (val) {
                      setState(() => title = val);
                      print(title);
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
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
                    onChanged: (val) {
                      setState(() => location = val);
                      print(location);
                    },
                    decoration: InputDecoration(
                        labelText: 'Location',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Location cannot be null';
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onEditingComplete: () => node.nextFocus(),
                    onChanged: (val) {
                      setState(() => description = val);
                      print(description);
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                    child: Text(
                        'Coordinates: ${widget.point.latitude.truncateToDouble()}, ${widget.point.longitude.truncateToDouble()}',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print(widget.point);
                        await _data.addEvent(user.uid, pickedDate, typeOfEvent,
                            title, location, description);
                        Navigator.of(context).pop();
                        showAlertDialog(context);
                      }
                    },
                    child: Text('Create Event'),
                  ),
                ]),
              )),
        ]));
  }
}
