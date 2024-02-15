import 'package:flutter/material.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
<<<<<<< Updated upstream
import 'package:knockknock/senior/screen/record_senior.dart';

class ResponseCompletePage extends StatelessWidget {
  const ResponseCompletePage({super.key});
=======
import 'package:knockknock/senior/component/my_bottomnavigationbar.dart';
import 'package:knockknock/senior/screen/emergency_senior.dart';
import 'package:knockknock/senior/screen/home_senior.dart';
import 'package:knockknock/senior/screen/record_senior.dart';
import 'package:knockknock/senior/senior.inital.dart';

class ResponseCompletePage extends StatefulWidget {
  const ResponseCompletePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResponseCompletePage();
}

class _ResponseCompletePage extends State<ResponseCompletePage> {
  void goHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
  final List<Widget> _navIndex = [
    const RecordPage(),
    const HomePage(),
    const EmergencyPage(),
  ];
  int _selectedIndex = 0;
  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: MyCustomBottomNavigationBar(
      //   onTabTapped: _onNavTapped,
      // ),
<<<<<<< Updated upstream
      appBar: const MyAppBar(
        myLeadingWidth: 130,
=======
      appBar: MyAppBar(
        myLeadingWidth: 130,
        leadingText: '홈으로',
        leadingCallback: goHome,
>>>>>>> Stashed changes
      ),
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xffEDEDF4)),
        child: Stack(
          children: [
            //사회복지사 프로필+이름
            Positioned(
              left: 0,
              right: 0,
              top: 50,
              child: Container(
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
<<<<<<< Updated upstream
                            image: AssetImage('assets/basic_profile.png'),
=======
                            image: AssetImage('assets/images/basic_profile.png'),
>>>>>>> Stashed changes
                          ),
                        ),
                      ),
                    ),
<<<<<<< Updated upstream
                    const Positioned(
=======
                     Positioned(
>>>>>>> Stashed changes
                      left: 0,
                      right: 0,
                      top: 170,
                      child: SizedBox(
                        child: Text(
<<<<<<< Updated upstream
                          'managerName' + ' 사회복지사',
                          textAlign: TextAlign.center,
                          style: TextStyle(
=======
                           managerName + ' 사회복지사',
                          textAlign: TextAlign.center,
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
              left: 50,
              right: 50,
              top: 270,
              child: Container(
                width: 30,
                height: 200,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 206, 206, 206), width: 3),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '대답하셨습니다!',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Transform.scale(
                        scale: 2,
                        child: Checkbox(
                          activeColor:
                              const Color.fromARGB(255, 0, 0, 0).withOpacity(1),
                          value: true,
                          onChanged: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 마지막 대답 날짜
            Positioned(
              left: 35,
              right: 35,
              top: 600,
              child: SizedBox(
                width: 325,
                height: 200,
                child: Text(
                  '마지막 대답 날짜: \n지금',
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
            // 기록 화면 가기 버튼
            Positioned(
              left: 40,
              right: 40,
              top: 500,
              child: OutlinedButton(
                onPressed: () {
<<<<<<< Updated upstream
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RecordPage()));
                },
                child: Text(
=======
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                           SeniorInitial(i: 0)));
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(333, 83),
                  backgroundColor: const Color(0xFF3475EB),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                ),
                child: const Text(
>>>>>>> Stashed changes
                  '기록 화면 가기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
<<<<<<< Updated upstream
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(333, 83),
                  backgroundColor: const Color(0xFF3475EB),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                ),
=======
>>>>>>> Stashed changes
              ),
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
}
