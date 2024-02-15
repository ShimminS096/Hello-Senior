import 'package:flutter/material.dart';
import 'package:knockknock/senior/component/my_bottomnavigationbar.dart';
import 'package:knockknock/senior/screen/emergency_2_senior.dart';
import 'package:knockknock/senior/screen/emergency_senior.dart';
import 'package:knockknock/senior/screen/home_senior.dart';
import 'package:knockknock/senior/screen/profile_senior.dart';
import 'package:knockknock/senior/screen/record_senior.dart';
import 'package:knockknock/senior/screen/response_2_senior.dart';
import 'package:knockknock/senior/screen/response_senior.dart';
// import 'package:badges/badges.dart' as badges;

class SeniorInitial extends StatefulWidget {
  const SeniorInitial({Key? key}) : super(key: key);

  @override
  State<SeniorInitial> createState() => _SeniorMainState();
}

class _SeniorMainState extends State<SeniorInitial> {
  int _selectedIndex = 1;

  final List<Widget> _navIndex = [
    const RecordPage(),
    const HomePage(),
    const EmergencyPage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Scaffold(
            body: _navIndex[_selectedIndex],
          )),
      routes: {
        '/home': (context) => const HomePage(),
        '/response': (context) => ResponsePage(),
        '/response_2': (context) => const ResponseCompletePage(),
        '/record': (context) => RecordPage(),
        '/emergency': (context) => const EmergencyPage(),
        '/emergency_2': (context) => const EmergencyCompletePage(),
        '/profile': (context) => const SeniorProfile(),
      },
    );
  }
}
