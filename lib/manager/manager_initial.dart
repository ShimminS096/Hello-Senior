import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/components/mypopup.dart';
import 'package:knockknock/manager/m_components/m_nav_bar.dart';
import 'package:knockknock/manager/nav1_message/m_message_initial.dart';
import 'package:knockknock/manager/nav2_todo/m_todo_initial.dart';
import 'package:knockknock/manager/nav3_home/m_home_initial.dart';
import 'package:knockknock/manager/nav4_location/m_location_initial.dart';
import 'package:knockknock/manager/nav5_menu/m_menu_initial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String currentUserID = auth.currentUser!.uid;

class ManagerInitial extends StatefulWidget {
  const ManagerInitial({Key? key}) : super(key: key);

  @override
  State<ManagerInitial> createState() => _ManagerInitialState();
}

class _ManagerInitialState extends State<ManagerInitial> {
  int _selectedIndex = 2;
  late int _numberofSeniors;

  @override
  void initState() {
    super.initState();
    _initializeNumberofSeniors();
  }

  Future<void> _initializeNumberofSeniors() async {
    _numberofSeniors = await _getNumberOfSeniors();
  }

  Future<int> _getNumberOfSeniors() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .get();
    final seniorUIDs = docSnapshot['seniorUIDs'] as List<dynamic>;
    setState(() {
      _numberofSeniors = seniorUIDs.length;
    });

    return seniorUIDs.length;
  }

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
        return ManagerMessageInitial();
      case 1:
        return ManagerTodoInitial(
          numberofSeniors: _numberofSeniors,
          currentUserUID: currentUserID,
        );
      case 2:
        return ManagerHomeInitial();
      case 3:
        return ManagerLocationInitial(numberofSeniors: _numberofSeniors);
      case 4:
        return ManagerMenuInitial();
      default:
        return ManagerHomeInitial();
    }
  }
}
