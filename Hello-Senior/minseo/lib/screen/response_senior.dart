import 'package:flutter/material.dart';


class ResponsePage extends StatelessWidget {
  const ResponsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393,
      height: 852,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFFEDEDF4)),
      //배경
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
          // 대답하기 버튼
          Positioned(
            left: 37,
            top: 561,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/response_2');
              },
              child: const Text('대답하기',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),),
              style: OutlinedButton.styleFrom(
                fixedSize: Size(333, 83),
                backgroundColor: Color(0xFF3475EB),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60))),
              ),
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
