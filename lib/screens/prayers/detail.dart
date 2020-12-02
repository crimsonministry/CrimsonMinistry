import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'package:CrimsonMinistry/services/database.dart';
import './prayedlist.dart';

class DetailPage extends StatefulWidget {
  final DatabaseService _data = DatabaseService();
  final Prayer prayer;
  final UserData creatorData;

  DetailPage({Key key, @required this.prayer, this.creatorData}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  showUser(bool anonymous, UserData creatorData) {
    if (anonymous == true) {
      return 'Anonymous User';
    }
    else {
      return '${creatorData.fname} ${creatorData.lname}';
    }
  }


  @override
  Widget build(BuildContext context) {
    User viewer = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: viewer.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('${widget.prayer.title}'),
                backgroundColor: Colors.red,
              ),
              body: Column(children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Description',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text('${widget.prayer.description}'),
                        leading: Icon(Icons.description,
                            color: Colors.blueGrey[900], size: 35),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Created by',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text(showUser(widget.prayer.anonymous, widget.creatorData)),
                        leading: Icon(Icons.account_circle,
                            color: Colors.blueGrey[900], size: 35),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 30),
                          child: (widget.prayer.prayerInteractions.contains(viewer.uid))
                              ? Text("Thanks for your prayer!")
                              : RaisedButton(
                                  child: Text('Pray'),
                                  onPressed: () async {
                                    widget.prayer.prayerInteractions.add(viewer.uid);
                                    userData.prayedList.add(widget.prayer.id);
                                    await widget._data.addToPrayerInteractions(
                                        viewer.uid,
                                        userData.prayedList,
                                        widget.prayer.id,
                                        widget.prayer.prayerInteractions);
                                  })),
                      RaisedButton(
                        child: Text('View Prayed List'),
                        color: Colors.orange[300],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PrayedList(widget.prayer.prayerInteractions),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            );
          } else {
            return Text('loading...');
          }
        });
  }
}
