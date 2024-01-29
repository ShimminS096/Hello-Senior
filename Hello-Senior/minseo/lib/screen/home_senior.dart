import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393,
      height: 852,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFFEDEDF4)), //배경
      child: Stack(
        children: [
          // 배경 색
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 393,
              height: 852,
              decoration: BoxDecoration(color: Color(0xFFEDEDF4)),
            ),
          ),
          // '뒤로 가기'
          Positioned(
            left: 18,
            top: 64,
            child: SizedBox(
              width: 91,
              height: 23,
              child: Text(
                '뒤로 가기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          // 프로필
          Positioned(
            left: 18,
            top: 122,
            child: Container(
              width: 354,
              height: 148,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 354,
                      height: 148,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(51),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 13,
                    top: 19,
                    child: Container(
                      width: 110,
                      height: 109,
                      child: Stack(children: [
                      ]),
                    ),
                  ),
                  Positioned(
                    left: 141,
                    top: 35,
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
                  Positioned(
                    left: 141,
                    top: 69,
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
                  Positioned(
                    left: 141,
                    top: 105,
                    child: SizedBox(
                      width: 205,
                      child: Text(
                        '담당 사회복지사 : 김아무개 (마포구노인복지센터)',
                        style: TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 9,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0.17,
                          letterSpacing: -0.10,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 141,
                    top: 94,
                    child: Container(
                      width: 181,
                      height: 7,
                      decoration: ShapeDecoration(
                        color: Color(0xCC3475EB),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 알림 버튼, 긴급 호출 버튼
          Positioned(
            left: 42,
            top: 306,
            child: Container(
              width: 309,
              height: 360,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: OutlinedButton.icon(
                      onPressed: (){
                        Navigator.pushNamed(context, '/response');
                      },
                      icon: Icon(Icons.person_pin_outlined, size: 60),
                      label: const Text('알림',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),),
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(309, 168),
                        backgroundColor: Color(0xFF3475EB),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(39))),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 192,
                    child: OutlinedButton.icon(
                      onPressed: (){
                        Navigator.pushNamed(context, '/emergency');
                      },
                      icon: Icon( null , size: 60),
                      label: const Text('긴급\n호출',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),),
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(309, 168),
                        backgroundColor: Color(0xFFF24822),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(39))),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 65,
                    top: 50.92,
                    child: Container(
                      width: 153,
                      height: 271.08,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 187.08,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/Siren_white.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 하단 네비게이션 바
          Positioned(
            left: 0,
            top: 720,
            child: Container(
              width: 393,
              height: 140,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 19,
                    child: Container(
                      width: 393,
                      height: 90,
                      decoration: BoxDecoration(color: Colors.white), // 네비게이션 바
                    ),
                  ),
                  Positioned(
                    left: 11,
                    top: 31,
                    child: Container(
                      width: 110.28,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/Urgent Message.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 290,
                    top: 27,
                    child: Container(
                      width: 60,
                      height: 62,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 62,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/Siren.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 161,
                    top: 21,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/home_icon.png"), // 중앙
                          fit: BoxFit.cover,
                        ),
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
  }
}
