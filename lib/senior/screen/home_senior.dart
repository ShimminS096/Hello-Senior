import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/my_bottomnavigationbar.dart';
import 'package:knockknock/senior/screen/emergency_senior.dart';
import 'package:knockknock/senior/screen/profile_senior.dart';
import 'package:knockknock/senior/screen/record_senior.dart';
import 'package:knockknock/senior/screen/response_senior.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String currentUserID = auth.currentUser!.uid;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String senioruid = currentUserID;
  String seniorName = ""; // [하드코딩]현재 사용자(돌봄 대상자)의 이름
  String seniorAddress = "";

  String manageruid = ""; // [하드코딩]
  String managerName = ""; // [하드코딩]
  String managerOccupation = ""; // [하드코딩]
  String managerWorkplace = "";

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

  //현재 회원의 정보 가져오기
  void fetchSeniorInfo() async {
    /*
    ["users" 컬렉션 > '현재 돌봄 대상자 문서] 가져오기
    */
    DocumentSnapshot seniorInfoSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(senioruid)
        .get();

    /* 
    현재 돌봄 대상자 문서의 정보를 data 라는 Map에 필드별로 넣기 & 정보 가져오기
    */
    Map<String, dynamic> data =
        await seniorInfoSnapshot.data() as Map<String, dynamic>;

    seniorName = data['seniorName'];
    seniorAddress = data['address'];
    manageruid = data['managerUID'];

    /*
    ["users" 컬렉션 > '현재 돌봄 대상자 문서] 가져오기
    */
    DocumentSnapshot managerInfoSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(manageruid)
        .get();

    /* 
    현재 돌봄 대상자 문서의 정보를 data 라는 Map에 필드별로 넣기 & 정보 가져오기
    */
    Map<String, dynamic> managerdata =
        managerInfoSnapshot.data() as Map<String, dynamic>;

    managerName = managerdata['managerName'];
    managerOccupation = managerdata['occupation'];
    managerWorkplace = managerdata['workplace'];

    setState(() {
      managerName = managerName;
      seniorName = seniorName;
      managerOccupation = managerOccupation;
      manageruid = manageruid;
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchSeniorInfo();
    Widget bodyWidget = Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xffEDEDF4)),
      child: Stack(
        children: [
          // 프로필
          Positioned(
            left: 30,
            right: 30,
            bottom: MediaQuery.of(context).size.height / 2 + 50,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SeniorProfile()));
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
                    Positioned(
                      left: 141,
                      top: 50,
                      child: SizedBox(
                        width: 103,
                        child: Text(
                          seniorName,
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
                    Positioned(
                      left: 141,
                      top: 80,
                      child: SizedBox(
                        width: 176,
                        child: Text(
                          seniorAddress,
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
                    Positioned(
                      left: 141,
                      top: 110,
                      child: SizedBox(
                        width: 190,
                        child: Text(
                          '담당 ' +
                              managerOccupation +
                              ' : ' +
                              managerName +
                              ' (' +
                              managerWorkplace +
                              ')',
                          style: const TextStyle(
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
                          color: const Color(0xCC3475EB).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
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
                              builder: (context) => ResponsePage(
                                senioruid: senioruid,
                                seniorName: seniorName,
                                manageruid: manageruid,
                                managerName: managerName,
                                managerOccupation: managerOccupation,
                              ),
                            ));
                      },
                      icon: const Icon(Icons.person_pin_outlined, size: 60),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(39))),
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
                      icon: const Icon(Icons.emergency, size: 60),
                      label: const Text(
                        '긴급\n호출',
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
                                BorderRadius.all(Radius.circular(39))),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 65,
                    top: 50.92,
                    child: SizedBox(
                      width: 153,
                      height: 271.08,
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
    } else if (_selectedIndex == 2) {
      bodyWidget = _navIndex[_selectedIndex];
    }
    return DefaultTabController(
        length: 3, // 하단 네비게이션 바의 아이템 개수
        initialIndex: _selectedIndex, // 초기 선택된 인덱스
        child: Scaffold(
          backgroundColor: _selectedIndex == 2
              ? const Color(0xffeeccca)
              : MyColor.myBackground,
          appBar: _selectedIndex != 1
              ? null
              : MyAppBar(
                  leadingText: '로그아웃',
                  leadingCallback: onLogout,
                  myLeadingWidth: 130,
                ),
          bottomNavigationBar: _selectedIndex != 1
              ? null
              : MyCustomBottomNavigationBar(onTabTapped: _onNavTapped),
          body: bodyWidget,
        ));
  }
}
