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

  prayed(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Prayed!"),
      content: Text("You've been added to the prayed list :))"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  unprayed(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Removed :("),
      content: Text("You've been removed from the prayed list :("),
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
                        subtitle: Text('${prayer.userID}'),
                        leading: Icon(Icons.account_circle,
                            color: Colors.blueGrey[900], size: 35),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(8.0, 30.0, 0.0, 0.0),
                        child: RaisedButton(
                          child: (prayer.prayerInteractions.contains(user.uid))
                              ? const Text('Remove from List')
                              : const Text('Pray'),
                          onPressed: () async {
                            if (prayer.prayerInteractions.contains(user.uid)) {
                              prayer.prayerInteractions.remove(user.uid);
                              userData.prayedList.remove(prayer.id);
                              await _data.addToPrayerInteractions(
                                  user.uid,
                                  userData.prayedList,
                                  prayer.id,
                                  prayer.prayerInteractions);
                              Navigator.of(context).pop();
                              unprayed(context);
                            } else {
                              prayer.prayerInteractions.add(user.uid);
                              userData.prayedList.add(prayer.id);
                              await _data.addToPrayerInteractions(
                                  user.uid,
                                  userData.prayedList,
                                  prayer.id,
                                  prayer.prayerInteractions);
                              Navigator.of(context).pop();
                              prayed(context);
                            }
                          },
                        ),
                      ),
                      RaisedButton(
                        child: Text('View Prayed List'),
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
