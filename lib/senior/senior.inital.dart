import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/screen/emergency_2_senior.dart';
import 'package:knockknock/senior/screen/emergency_senior.dart';
import 'package:knockknock/senior/screen/home_senior.dart';
import 'package:knockknock/senior/screen/profile_senior.dart';
import 'package:knockknock/senior/screen/record_senior.dart';
import 'package:knockknock/senior/screen/response_2_senior.dart';
import 'package:knockknock/senior/screen/response_senior.dart';
// import 'package:badges/badges.dart' as badges;

class SeniorInitial extends StatefulWidget {
  const SeniorInitial({
    Key? key,
    this.i,
  }) : super(key: key);

  final int? i;

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
            backgroundColor: _selectedIndex == 2
                ? MyColor.myBackground
                : const Color(0xffEDEDF4),
            body:
                widget.i == 0 ? const RecordPage() : _navIndex[_selectedIndex],
          )),
      routes: {
        '/home': (context) => const HomePage(),
        '/response': (context) => ResponsePage(
              senioruid: '',
              seniorName: '',
              manageruid: '',
              managerName: '',
              managerOccupation: '',
            ),
        '/response_2': (context) => ResponseCompletePage(
              manageruid: '',
              managerName: '',
              managerOccupation: '',
              senioruid: '',
            ),
        '/record': (context) => const RecordPage(),
        '/emergency': (context) => const EmergencyPage(),
        '/profile': (context) =>  SeniorProfile(),
      },
    );
  }
}
