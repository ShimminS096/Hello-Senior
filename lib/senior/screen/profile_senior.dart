import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore 추가
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/profile_imang_name.dart';
import 'package:knockknock/senior/component/profile_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SeniorProfile extends StatelessWidget {
  const SeniorProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser; // 현재 사용자 가져오기

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc('ZGL42b7A51pxoNxoJKPe') //하드코딩: currentUser?.uid로 수정해야함
          .get(), // 현재 사용자 문서를 Future로 가져오기
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 데이터를 기다리는 중이면 로딩 표시
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text("데이터를 찾을 수 없습니다."); // 데이터가 없거나 오류가 발생한 경우
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xffEDEDF4),
          appBar: const MyAppBar(
            myLeadingWidth: 130,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: ProfileImageName(
                    photo: userData['photoUrl'] ??
                        "assets/images/basic_profile.png",
                    name: userData['seniorName'] ?? "이름",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: ProfileInfo(
                    firstTitle: '전화번호',
                    firstContent: userData['phoneNumber'] ?? "010-1234-5678",
                    seceondTitle: '주소',
                    secondContent: userData['address'] ?? "서울특별시 마포구 와우산로 94",
                    thirdTitle: '보호자',
                    thirdContent:
                        userData['protectorPhoneNumber'] ?? "010-2345-6789",
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Text(
                        "특이사항 \n\t ${userData['characteristics'] ?? '1형 당뇨'}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
