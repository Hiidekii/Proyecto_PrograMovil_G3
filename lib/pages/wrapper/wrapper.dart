import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/components/bottom_bar.dart';
import 'package:proyecto_programovil_g3/pages/events/events_page.dart';
import 'package:proyecto_programovil_g3/pages/home/home_page.dart';
import 'package:proyecto_programovil_g3/pages/profile/profile_page.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeTab(),
    EventsTab(),
    ProfileTab(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App')),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }
}
