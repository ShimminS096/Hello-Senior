import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/my_bottomnavigationbar.dart';
import 'package:knockknock/senior/screen/emergency_2_senior.dart';
import 'package:knockknock/senior/screen/home_senior.dart';
import 'package:knockknock/senior/screen/record_senior.dart';
import 'package:knockknock/senior/senior.inital.dart';

String managerName = '김 아무개';
String seniorAddress = '서울특별시 마포구 와우산로 94';
String nokPhoneNumber = '010-1234-5678';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmergencyPage();
}

class _EmergencyPage extends State<EmergencyPage> {
  int _selectedIndex = 2;
  void goHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

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
    return DefaultTabController(
      length: 3, // 하단 네비게이션 바의 아이템 개수
      initialIndex: 2,
      child: Scaffold(
        backgroundColor: _selectedIndex == 2
            ? const Color(0xffeeccca)
            : MyColor.myBackground,
        appBar: _selectedIndex != 2
            ? null
            : MyAppBar(
                leadingText: '홈으로',
                leadingCallback: goHome,
                myLeadingWidth: 130,
              ),
        bottomNavigationBar: _selectedIndex != 2
            ? null
            : MyCustomBottomNavigationBar(onTabTapped: _onNavTapped),
        body: _selectedIndex != 2
            ? SeniorInitial(
                i: _selectedIndex,
              )
            : Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: MyColor.myBackground),
                child: Stack(
                  children: [
                    //사회복지사 프로필+이름
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 50,
                      child: SizedBox(
                        width: 354,
                        height: 200,
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
                                    image: AssetImage(
                                        'assets/images/basic_profile.png'),
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
                                  style: const TextStyle(
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
                    //위치+연락처 정보
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 370,
                      child: Container(
                        width: 30,
                        height: 250,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Center(
                          child: Column(children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 230,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.transparent, // 투명 배경
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: const Color(0xFFCCCCCC),
                                    width: 4), // 회색 테두리
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 80,
                                    color: MyColor.myRed,
                                  ),
                                  Text(
                                    '서울특별시 마포구 와우산로 94',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              '보호자 연락처',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              width: 230,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.transparent, // 투명 배경
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: const Color(0xFFCCCCCC),
                                    width: 4), // 회색 테두리
                              ),
                              child: Text(
                                nokPhoneNumber,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ]),
                        ),
                      ),
                    ),
                    // Red box
                    Positioned(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: const Color(0x00f24822).withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                    ),
                    // 긴급 전송 버튼
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 250,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EmergencyCompletePage()));
                        },
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size(333, 70),
                          backgroundColor: MyColor.myRed,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        child: const Text(
                          '연락처 & 위치 정보 전송',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    // '긴급 상황이십니까?'
                    const Positioned(
                      left: 0,
                      right: 0,
                      top: 335,
                      child: SizedBox(
                        width: 201,
                        height: 34,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Positioned(
                                left: 0,
                                right: 0,
                                top: -5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: 30,
                                      color: MyColor.myRed,
                                    ),
                                    Text(
                                      '  긴급 상황이십니까?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: MyColor.myRed,
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w800,
                                        height: 0,
                                        letterSpacing: -0.38,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
