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
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.softYellow,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(
                icon: CupertinoIcons.house_alt,
                isActive: currentIndex == 0,
                index: 0,
                onTap: onTabTapped,
              ),
              _buildTabItem(
                icon: CupertinoIcons.collections,
                isActive: currentIndex == 1,
                index: 1,
                onTap: onTabTapped,
              ),
              // _buildTabItem(
              //   icon: CupertinoIcons.square_list,
              //   isActive: currentIndex == 2,
              //   index: 2,
              //   onTap: onTabTapped,
              // ),
              _buildTabItem(
                icon: CupertinoIcons.square_grid_2x2,
                isActive: currentIndex == 2,
                index: 2,
                onTap: onTabTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required IconData icon,
    required bool isActive,
    required int index,
    required Function(int) onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        width: 50,
        height: 50,
        child: Icon(
          icon,
          size: 32,
          color: isActive ? Colors.orangeAccent : Colors.black87,
        ),
      ),
    );
  }
}
