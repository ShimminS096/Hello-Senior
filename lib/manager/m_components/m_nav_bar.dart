import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class ManagerNavigationBar extends StatelessWidget {
  const ManagerNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          iconSize: 50,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: MyColor.myBlue,
          unselectedItemColor: MyColor.myLightBlue,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.mail), label: '메세지'),
            BottomNavigationBarItem(
                icon: Icon(Icons.sticky_note_2), label: '할 일'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.location_on), label: '위치'),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_rounded), label: '메뉴'),
          ],
          onTap: onTap,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}
