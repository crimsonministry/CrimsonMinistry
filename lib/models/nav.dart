import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/screens/prayers/prayers.dart';
import 'package:CrimsonMinistry/screens/account/account.dart';
import 'package:CrimsonMinistry/screens/events/events.dart';

class NavObject {
  Widget screen;
  Icon navIcon;
  String label;
  NavObject({this.screen, this.navIcon, this.label});
}

List<NavObject> navItems = [
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
  NavObject(
    screen: Account(),
    navIcon: Icon(Icons.person),
    label: 'Account',
  ),
];
