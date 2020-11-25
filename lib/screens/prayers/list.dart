import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CrimsonMinistry/models/prayer.dart';
import 'tile.dart';

class PrayerList extends StatefulWidget {
  @override
  _PrayerListState createState() => _PrayerListState();
}

class _PrayerListState extends State<PrayerList> {
  @override
  Widget build(BuildContext context) {
    final prayers = Provider.of<List<Prayer>>(context) ?? [];

    return ListView.builder(
      itemCount: prayers.length,
      itemBuilder: (context, index) {
        return PrayerTile(prayer: prayers[index]);
      },
    );
  }
}
