import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/profile_imang_name.dart';
import 'package:knockknock/senior/component/profile_info.dart';

String name = '이름';
String phoneNumber = '010-1234-5678';
String address = '서울특별시 마포구 와우산로 94';
String nokNumber = '010-2345-6789';
String characteristics = '1형 당뇨';

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: ProfileImageName(
                photo: "assets/images/basic_profile.png",
                name: name,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: ProfileInfo(
                firstTitle: '전화번호',
                firstContent: phoneNumber,
                seceondTitle: '주소',
                secondContent: address,
                thirdTitle: '보호자',
                thirdContent: nokNumber,
                gap: 10,
              ),
            ),
            Container(
              width: 400,
              height: 250, // 기본 높이
              decoration: BoxDecoration(
                color: MyColor.myWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 450,
                height: 60,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    "특이사항 \n\t $characteristics",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
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
