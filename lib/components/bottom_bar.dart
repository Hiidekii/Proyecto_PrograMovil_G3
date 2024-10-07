import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomBar({required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(25), // Recorta el contenido al borde circular
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.softYellow, // Cambiado a softYellow
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTabTapped,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_alt,
                    size: 32, color: Colors.black87),
                activeIcon: Icon(CupertinoIcons.house_alt,
                    size: 32, color: Colors.orangeAccent),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.collections,
                    size: 32, color: Colors.black87),
                activeIcon: Icon(CupertinoIcons.collections,
                    size: 32, color: Colors.orangeAccent),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_list,
                    size: 32, color: Colors.black87),
                activeIcon: Icon(CupertinoIcons.square_list,
                    size: 32, color: Colors.orangeAccent),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.square_grid_2x2,
                    size: 32, color: Colors.black87),
                activeIcon: Icon(CupertinoIcons.square_grid_2x2,
                    size: 32, color: Colors.orangeAccent),
                label: '',
              ),
            ],
            selectedItemColor: Colors.orangeAccent,
            unselectedItemColor: Colors.black87,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
      ),
    );
  }
}
