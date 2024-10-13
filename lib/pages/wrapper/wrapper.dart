import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:proyecto_programovil_g3/components/bottom_bar.dart';
import 'package:proyecto_programovil_g3/pages/events/events_page.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/calendar_view.dart';
import 'package:proyecto_programovil_g3/pages/settings/settings_page.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/home_page.dart';

class Wrapper extends StatefulWidget {
  final Function onToggleTheme;

  Wrapper({required this.onToggleTheme});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _currentIndex = 0;

  final List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children.addAll([
      HomeTab(),
      EventsTab(),
      SettingsTab(
          onToggleTheme: () =>
              widget.onToggleTheme()), // Pasar la función para alternar el tema
    ]);
  }

  final List<String> _titles = ['Inicio', 'Eventos', 'Perfil'];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: [
          IconButton(icon: Icon(CupertinoIcons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(
              CupertinoIcons.calendar,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                builder: (BuildContext context) {
                  return const CalendarView();
                },
              );
            },
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }
}
