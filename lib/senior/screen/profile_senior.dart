import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/profile_imang_name.dart';
import 'package:knockknock/senior/component/profile_info.dart';

class SeniorProfile extends StatelessWidget {
  const SeniorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffEDEDF4),
      appBar: const MyAppBar(
        myLeadingWidth: 130,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Column(children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ProfileImageName(
                photo: "assets/images/basic_profile.png",
                name: '이름',
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              child: ProfileInfo(
                firstTitle: '전화번호',
                firstContent: '010-XXXX-XXXX',
                seceondTitle: '주소',
                secondContent: '서울특별시 마포구 와우산로 94',
                thirdTitle: '보호자',
                thirdContent: '010-OOOO-OOOO',
                gap: 10,
              ),
            ),
            Container(
              width: 450,
              height: 300, // 기본 높이
              decoration: BoxDecoration(
                color: MyColor.myWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const SizedBox(
                width: 450,
                height: 60,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    "특이사항",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            )
          ]),
        ]),
      ),
    );
  }
}
