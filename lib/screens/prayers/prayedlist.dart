import 'package:flutter/material.dart';
import './prayedtile.dart';

class PrayedList extends StatefulWidget {
  final List<String> prayerIteractions;
  PrayedList(this.prayerIteractions);

  @override
  _PrayedListState createState() => _PrayedListState();
}

class _PrayedListState extends State<PrayedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Prayed List'),
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.prayerIteractions.length,
          itemBuilder: (context, index) {
            return PrayedTile(userID: widget.prayerIteractions[index]);
          },
        ));
  }
}
