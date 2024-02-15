import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/profile_imang_name.dart';
import 'package:knockknock/senior/component/profile_info.dart';

<<<<<<< Updated upstream
class SeniorProfile extends StatelessWidget {
=======
String name = '이름';
String phoneNumber = '010-1234-5678';
String address = '서울특별시 마포구 와우산로 94';
String nokNumber = '010-2345-6789';
String characteristics = '1형 당뇨';
class SeniorProfile extends StatelessWidget {


>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
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
>>>>>>> Stashed changes
                gap: 10,
              ),
            ),
            Container(
<<<<<<< Updated upstream
              width: 450,
              height: 300, // 기본 높이
=======
              width: 400,
              height: 250, // 기본 높이
>>>>>>> Stashed changes
              decoration: BoxDecoration(
                color: MyColor.myWhite,
                borderRadius: BorderRadius.circular(20),
              ),
<<<<<<< Updated upstream
              child: const SizedBox(
                width: 450,
                height: 60,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    "특이사항",
                    style: TextStyle(fontSize: 22),
=======
              child: SizedBox(
                width: 450,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    "특이사항 \n\t $characteristics" ,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600,)
                    ,
>>>>>>> Stashed changes
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
