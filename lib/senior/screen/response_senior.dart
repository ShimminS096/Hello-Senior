import 'package:flutter/material.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/my_bottomnavigationbar.dart';
import 'package:knockknock/senior/screen/emergency_senior.dart';
import 'package:knockknock/senior/screen/home_senior.dart';
import 'package:knockknock/senior/screen/record_senior.dart';
import 'package:knockknock/senior/screen/response_2_senior.dart';

class ResponsePage extends StatefulWidget {
  const ResponsePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResponsePage();
}

class _ResponsePage extends State<ResponsePage> {
  void goBack() {}
  bool isKnocked = false;
  String managerName = '김 아무개';
  String knockTime = 'XX.XX OO:OO';
  String lastResponseTime = '20XX.XX.XX';

  int _selectedIndex = 0;
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
    if (!isKnocked) {
<<<<<<< Updated upstream
      return DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: _selectedIndex == 2
                ? const Color(0xffeeccca)
                : const Color(0xffEDEDF4),
            body: _navIndex[_selectedIndex],
            bottomNavigationBar: _selectedIndex == 1
                ? null
                : MyCustomBottomNavigationBar(
                    onTabTapped: _onNavTapped,
                  ),
          ));
=======
      return  Scaffold(
            body: _navIndex[_selectedIndex]
          );
>>>>>>> Stashed changes
    } else {
      return Scaffold(
        appBar: const MyAppBar(
          myLeadingWidth: 130,
        ),
        body: Container(
          clipBehavior: Clip.antiAlias,
<<<<<<< Updated upstream
          decoration: BoxDecoration(color: Color(0xFFEDEDF4)),
=======
          decoration: const BoxDecoration(color: Color(0xFFEDEDF4)),
>>>>>>> Stashed changes
          //배경
          child: Stack(
            children: [
              //사회복지사 프로필+이름
              Positioned(
                left: 0,
                right: 0,
                top: 50,
<<<<<<< Updated upstream
                child: Container(
=======
                child: SizedBox(
>>>>>>> Stashed changes
                  width: 354,
                  height: 250,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
<<<<<<< Updated upstream
                              image: AssetImage('assets/basic_profile.png'),
=======
                              image: AssetImage('assets/images/basic_profile.png'),
>>>>>>> Stashed changes
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 170,
                        child: SizedBox(
                          child: Text(
                            managerName + ' 사회복지사',
                            textAlign: TextAlign.center,
<<<<<<< Updated upstream
                            style: TextStyle(
=======
                            style: const TextStyle(
>>>>>>> Stashed changes
                              color: Color(0xFF1E1E1E),
                              fontSize: 30,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0.06,
                              letterSpacing: -0.53,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //'잘 계시나요?' 박스
              Positioned(
                  left: 40,
                  right: 40,
                  top: 270,
                  child: Container(
                    width: 30,
                    height: 200,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                            color: const Color.fromARGB(255, 206, 206, 206),
                            width: 3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        knockTime + '\n홍길동 님\n잘 계시나요?',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              // 마지막 대답 날짜
              Positioned(
                left: 35,
                right: 35,
                top: 600,
                child: SizedBox(
                  width: 325,
                  height: 200,
                  child: Text(
<<<<<<< Updated upstream
                    '마지막 대답 날짜:\n${lastResponseTime}20XX.XX.XX (4일 전)',
=======
                    '마지막 대답 날짜:\n${lastResponseTime}',
>>>>>>> Stashed changes
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1,
                      letterSpacing: -0.53,
                    ),
                  ),
                ),
              ),
              // 대답하기 버튼
              Positioned(
                left: 35,
                right: 35,
                top: 500,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ResponseCompletePage()));
                  },
                  child: const Text(
                    '대답하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(333, 83),
                    backgroundColor: Color(0xFF3475EB),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60))),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
