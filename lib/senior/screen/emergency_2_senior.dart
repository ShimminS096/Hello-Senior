import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/my_bottomnavigationbar.dart';
import 'package:knockknock/senior/screen/emergency_senior.dart';
import 'package:knockknock/senior/screen/home_senior.dart';
import 'package:knockknock/senior/screen/record_senior.dart';

class EmergencyCompletePage extends StatefulWidget {
  const EmergencyCompletePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmergencyCompletePage();
}

class _EmergencyCompletePage extends State<EmergencyCompletePage> {
  void goHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  int _selectedIndex = 2;
  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _navIndex = [
    const RecordPage(),
    const HomePage(),
    const EmergencyPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3, // 하단 네비게이션 바의 아이템 개수
        initialIndex: _selectedIndex,
        child: Scaffold(
          backgroundColor: MyColor.myBackground,
          appBar: _selectedIndex == 1
              ? null
              : MyAppBar(
                  leadingText: '홈으로',
                  leadingCallback: goHome,
                  myLeadingWidth: 130,
                ),
          bottomNavigationBar: _selectedIndex != 2
              ? null
              : MyCustomBottomNavigationBar(
                  onTabTapped: _onNavTapped,
                ),
          body: _selectedIndex != 2
              ? _navIndex[_selectedIndex]
              : Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(color: Color(0xFFEDEDF4)),
                  child: Stack(
                    children: [
                      // 배경
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 393,
                          height: 852,
                          decoration:
                              const BoxDecoration(color: Color(0xFFEDEDF4)),
                        ),
                      ),
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
                              const Positioned(
                                left: 0,
                                right: 0,
                                top: 170,
                                child: SizedBox(
                                  child: Text(
                                    '김아무개 사회복지사',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
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
                                      color: MyColor.myBlue,
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
                                      color: Color(0xFFCCCCCC),
                                      width: 4), // 회색 테두리
                                ),
                                child: const Text(
                                  '010-1234-5678',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
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
                      // 긴급 전송 버튼
                      Positioned(
                        left: 50,
                        right: 50,
                        top: 250,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color:
                                    const Color(0xFFF24822).withOpacity(0.5)),
                            fixedSize: const Size(333, 70),
                            backgroundColor:
                                const Color(0xFFF24822).withOpacity(0.5),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          child: const Text(
                            '연락처 & 위치 정보 전송 완료',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}