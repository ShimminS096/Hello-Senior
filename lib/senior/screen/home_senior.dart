import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/my_bottomnavigationbar.dart';
import 'package:knockknock/senior/screen/emergency_senior.dart';
import 'package:knockknock/senior/screen/profile_senior.dart';
import 'package:knockknock/senior/screen/record_senior.dart';
import 'package:knockknock/senior/screen/response_senior.dart';

class HomePage extends StatefulWidget {
<<<<<<< Updated upstream
  const HomePage({Key? key}) : super(key: key);
=======
  final VoidCallback? onButtonClicked;
  const HomePage({super.key, this.onButtonClicked});
>>>>>>> Stashed changes
  @override
  State<StatefulWidget> createState() => _HomePage();
}


class _HomePage extends State<HomePage> {
<<<<<<< Updated upstream
  bool isEmergencyButtonClicked = false;
=======
  String name = '홍길동';
  String address = '서울특별시 마포구 와우산로 94';
  String manager = '김아무개 (마포구노인복지센터)';

>>>>>>> Stashed changes
  int _selectedIndex = 1;
  void onLogout() {}
  void goHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

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
<<<<<<< Updated upstream
    return DefaultTabController(
=======
    Widget bodyWidget=Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xffEDEDF4)),
      child: Stack(
        children: [
          // 프로필
          Positioned(
            left: 30,
            right: 30,
            bottom: MediaQuery.of(context).size.height / 2 + 10,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const SeniorProfile()));
              },
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shadowColor: MyColor.myDarkGrey,
                  backgroundColor: MyColor.myWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
              child: SizedBox(
                width: 354,
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                      left: 25,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/basic_profile.png')),
                        ),
                      ),
                    ),
                     Positioned(
                      left: 141,
                      top: 50,
                      child: SizedBox(
                        width: 103,
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.06,
                            letterSpacing: -0.53,
                          ),
                        ),
                      ),
                    ),
                     Positioned(
                      left: 141,
                      top: 80,
                      child: SizedBox(
                        width: 176,
                        child: Text(
                          address,
                          style: const TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.12,
                            letterSpacing: -0.25,
                          ),
                        ),
                      ),
                    ),
                     Positioned(
                      left: 141,
                      top: 110,
                      child: SizedBox(
                        width: 180,
                        child: Text(
                          '담당 사회복지사 : $manager',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1,
                            letterSpacing: -0.10,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 141,
                      top: 100,
                      child: Container(
                        width: 180,
                        height: 8,
                        decoration: ShapeDecoration(
                          color: const Color(0xCC3475EB)
                              .withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 알림 버튼, 긴급 호출 버튼
          Positioned(
            left: 50,
            right: 50,
            top: 250,
            child: SizedBox(
              width: 309,
              height: 360,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ResponsePage()));
                      },
                      icon: const Icon(Icons.person_pin_outlined,
                          size: 60),
                      label: const Text(
                        '알림',
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
                        fixedSize: const Size(309, 168),
                        backgroundColor: const Color(0xFF3475EB),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(39))),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 192,
                    child: OutlinedButton.icon(
                      onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const EmergencyPage()));
                    },
                      icon: const Icon(Icons.warning_amber_rounded, size: 60),
                      label: const Text(
                        '긴급 호출',
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
                        fixedSize: const Size(309, 168),
                        backgroundColor: const Color(0xFFF24822),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(
                                Radius.circular(39))),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
    if (_selectedIndex == 0) {
      bodyWidget = _navIndex[_selectedIndex];
    } else if (_selectedIndex == 2) { bodyWidget = _navIndex[_selectedIndex]; }

    return  DefaultTabController(
>>>>>>> Stashed changes
        length: 3, // 하단 네비게이션 바의 아이템 개수
        initialIndex: _selectedIndex, // 초기 선택된 인덱스
        child: Scaffold(
            backgroundColor: _selectedIndex == 2
<<<<<<< Updated upstream
                ? const Color(0xffeeccca)
                : const Color(0xffEDEDF4),
            appBar: MyAppBar(
              leadingText: _selectedIndex == 1 ? '로그아웃' : '홈으로',
              leadingCallback: _selectedIndex == 1 ? onLogout : goHome,
              myLeadingWidth: 130,
            ),
            bottomNavigationBar : isEmergencyButtonClicked?  MyCustomBottomNavigationBar(
              onTabTapped: _onNavTapped,
            ) : MyCustomBottomNavigationBar(
          onTabTapped: _onNavTapped,
        ),
            body: _selectedIndex != 1
                ? _navIndex[_selectedIndex]
                : Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(color: Color(0xffEDEDF4)),
                    child: Stack(
                      children: [
                        // 프로필
                        Positioned(
                          left: 30,
                          right: 30,
                          bottom: MediaQuery.of(context).size.height / 2 + 80,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SeniorProfile()));
                            },
                            style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shadowColor: MyColor.myDarkGrey,
                                backgroundColor: MyColor.myWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                )),
                            child: SizedBox(
                              width: 354,
                              height: 180,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 25,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/basic_profile.png')),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 141,
                                    top: 50,
                                    child: SizedBox(
                                      width: 103,
                                      child: Text(
                                        '홍길동',
                                        style: TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 24,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          height: 0.06,
                                          letterSpacing: -0.53,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 141,
                                    top: 80,
                                    child: SizedBox(
                                      width: 176,
                                      child: Text(
                                        '서울특별시 마포구 와우산로 94',
                                        style: TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 13,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          height: 0.12,
                                          letterSpacing: -0.25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    left: 141,
                                    top: 110,
                                    child: SizedBox(
                                      width: 190,
                                      child: Text(
                                        '담당 사회복지사 : 김아무개 (마포구노인복지센터)',
                                        style: TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 13,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          height: 1,
                                          letterSpacing: -0.10,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 141,
                                    top: 100,
                                    child: Container(
                                      width: 190,
                                      height: 8,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xCC3475EB)
                                            .withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // 알림 버튼, 긴급 호출 버튼
                        Positioned(
                          left: 50,
                          right: 50,
                          top: 300,
                          child: SizedBox(
                            width: 309,
                            height: 360,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ResponsePage()));
                                    },
                                    icon: const Icon(Icons.person_pin_outlined,
                                        size: 60),
                                    label: const Text(
                                      '알림',
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
                                      fixedSize: const Size(309, 168),
                                      backgroundColor: const Color(0xFF3475EB),
                                      foregroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(39))),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 192,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      _onNavTapped(2);
                                    },
                                    icon: const Icon(Icons.warning_amber_rounded, size: 60),
                                    label: const Text(
                                      '긴급 호출',
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
                                      fixedSize: const Size(309, 168),
                                      backgroundColor: const Color(0xFFF24822),
                                      foregroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(39))),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
=======
                ? const Color(0xffeeccca) : MyColor.myBackground,
            appBar:  _selectedIndex != 1 ? null : MyAppBar(
              leadingText: '로그아웃',
              leadingCallback: onLogout,
              myLeadingWidth: 130,
            ),
            bottomNavigationBar: _selectedIndex != 1 ? null : MyCustomBottomNavigationBar(
                onTabTapped: _onNavTapped ),
            body: bodyWidget,

                 ));
>>>>>>> Stashed changes
  }
}
