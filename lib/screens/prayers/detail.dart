import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/user.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'package:CrimsonMinistry/services/database.dart';
import './prayedlist.dart';

class DetailPage extends StatelessWidget {
  final DatabaseService _data = DatabaseService();
  final Prayer prayer;
  DetailPage({Key key, @required this.prayer}) : super(key: key);

  showUser(bool anonymous) {
    if (anonymous) {
      return 'Anonymous User';
    } else {
      return prayer.userID;
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('${prayer.title}'),
                backgroundColor: Colors.red,
              ),
              body: Column(children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Description',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text('${prayer.description}'),
                        leading: Icon(Icons.description,
                            color: Colors.blueGrey[900], size: 35),
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Created by',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text(showUser(prayer.anonymous)),
                        leading: Icon(Icons.account_circle,
                            color: Colors.blueGrey[900], size: 35),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 30),
                          child: (prayer.prayerInteractions.contains(user.uid))
                              ? Text("Thanks for your prayer!")
                              : RaisedButton(
                                  child: Text('Pray'),
                                  onPressed: () async {
                                    prayer.prayerInteractions.add(user.uid);
                                    userData.prayedList.add(prayer.id);
                                    await _data.addToPrayerInteractions(
                                        user.uid,
                                        userData.prayedList,
                                        prayer.id,
                                        prayer.prayerInteractions);
                                  })),
                      RaisedButton(
                        child: Text('View Prayed List'),
                        color: Colors.orange[300],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PrayedList(prayer.prayerInteractions),
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
