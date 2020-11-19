import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/screens/events/events.dart';
import 'package:CrimsonMinistry/screens/map/map.dart';
import 'package:CrimsonMinistry/screens/prayers/prayers.dart';

class NavObject {
  Widget screen;
  Icon navIcon;
  String label;
  NavObject({this.screen, this.navIcon, this.label});
}

List<NavObject> navItems = [
  NavObject(
    screen: MapPage(),
    navIcon: Icon(Icons.explore),
    label: 'Map',
  ),
  NavObject(
    screen: Events(),
    navIcon: Icon(Icons.event),
    label: 'Events',
  ),
  NavObject(
    screen: Prayers(),
    navIcon: Icon(Icons.public),
    label: 'Prayers',
  ),
];
