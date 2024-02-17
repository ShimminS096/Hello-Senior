import 'package:flutter/material.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
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
      return Scaffold(body: _navIndex[_selectedIndex]);
    } else {
      return Scaffold(
        appBar: const MyAppBar(
          myLeadingWidth: 130,
        ),
        body: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFFEDEDF4)),
          //배경
          child: Stack(
            children: [
              //사회복지사 프로필+이름
              Positioned(
                left: 0,
                right: 0,
                top: 50,
                child: SizedBox(
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
                              image:
                                  AssetImage('assets/images/basic_profile.png'),
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
                        side: const BorderSide(
                            color: Color.fromARGB(255, 206, 206, 206),
                            width: 3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$knockTime\n홍길동 님\n잘 계시나요?',
                        style: const TextStyle(
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
                    '마지막 대답 날짜:\n${lastResponseTime}',
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
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(333, 83),
                    backgroundColor: const Color(0xFF3475EB),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60))),
                  ),
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
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
