import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class MyCustomBottomNavigationBar extends StatelessWidget {
  final Function(int) onTabTapped;
<<<<<<< Updated upstream

  MyCustomBottomNavigationBar({required this.onTabTapped});
=======
  const MyCustomBottomNavigationBar({super.key, required this.onTabTapped});
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          height: 125,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Container(
            color: Colors.white.withOpacity(1), //네비게이션 바 색
            height: 100,
            child: Container(
              // color: Colors.white, //네비게이션 바 색
              height: 100,
<<<<<<< Updated upstream
              alignment: Alignment(0, 0),
=======
              alignment: const Alignment(0, 0),
>>>>>>> Stashed changes
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: MyColor.myBlue,
                indicatorWeight: 5,
                labelColor: MyColor.myBlue,
                unselectedLabelColor: Colors.black,
<<<<<<< Updated upstream
                labelStyle: TextStyle(fontSize: 15),
=======
                labelStyle: const TextStyle(fontSize: 15),
>>>>>>> Stashed changes
                tabs: const [
                  Tab(
                    icon: Icon(Icons.chat, size: 40),
                    text: '기록',
                  ),
                  Tab(
                    icon: Icon(Icons.home, size: 40),
                    text: '홈',
                  ),
                  Tab(
                    icon: Icon(Icons.person_pin_outlined, size: 40),
                    text: '긴급 호출',
                  )
                ],
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
                onTap: onTabTapped,
              ),
            ),
            // 하단 네비게이션 바 아래에 원 추가
          ),
        ),
        // 하단 네비게이션 바
      ],
    );
  }
<<<<<<< Updated upstream
}
=======
}
>>>>>>> Stashed changes
