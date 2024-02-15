import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_nav_bar.dart';
import 'package:knockknock/manager/nav1_message/m_message_initial.dart';
import 'package:knockknock/manager/nav2_todo/m_todo_initial.dart';
import 'package:knockknock/manager/nav3_home/m_home_initial.dart';
import 'package:knockknock/manager/nav4_location/m_location_initial.dart';
import 'package:knockknock/manager/nav5_menu/m_menu_initial.dart';

class ManagerInitial extends StatefulWidget {
  const ManagerInitial({super.key});

  @override
  State<ManagerInitial> createState() => _ManagerInitialState();
}

class _ManagerInitialState extends State<ManagerInitial> {
  int _selectedIndex = 2;
  int numberofSeniors = 10;

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: MyColor.myBackground,
        body: _buildSelectedScreen(),
        bottomNavigationBar: ManagerNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onNavTapped,
        ),
      ),
    );
  }

  Widget _buildSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return ManagerMessageInitial(numberofSeniors: numberofSeniors);
      case 1:
        return ManagerTodoInitial(numberofSeniors: numberofSeniors);
      case 2:
        return ManagerHomeInitial(numberofSeniors: numberofSeniors);
      case 3:
        return ManagerLocationInitial(numberofSeniors: numberofSeniors);
      case 4:
        return const ManagerMenuInitial();
      default:
        return ManagerHomeInitial(numberofSeniors: numberofSeniors);
    }
  }
}
