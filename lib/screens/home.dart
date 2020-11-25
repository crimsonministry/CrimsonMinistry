import 'package:flutter/material.dart';
import 'package:CrimsonMinistry/models/nav.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  int _screenNumber = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: navItems[_screenNumber].screen,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: navItems
            .map((navItem) => BottomNavigationBarItem(
                  icon: navItem.navIcon,
                  label: navItem.label,
                ))
            .toList(),
        currentIndex: _screenNumber,
        onTap: (i) => setState(() {
          _screenNumber = i;
        }),
      ),
    );
  }
}
