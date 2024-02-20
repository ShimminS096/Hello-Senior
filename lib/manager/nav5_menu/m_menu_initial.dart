import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:knockknock/senior/screen/profile_senior.dart';

class ManagerMenuInitial extends StatefulWidget {
  ManagerMenuInitial({super.key});

  @override
  State<ManagerMenuInitial> createState() => _ManagerMenuInitialState();
}

class _ManagerMenuInitialState extends State<ManagerMenuInitial> {
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _belongController = TextEditingController();

  bool isManagerEditing = false;

  String name = "";
  String phonenumber = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final currentUser = 'OI75iw9Z1oTlV2EyyL8C'; //현재 user로 변경해야함
    if (currentUser != null) {
      //final uid = currentUser.uid;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc('OI75iw9Z1oTlV2EyyL8C')
          .get();

      Map<String, dynamic> data = userData.data() as Map<String, dynamic>;

      setState(() {
        name = data['managerName'];
        phonenumber = data['phonenumber'];
        _belongController.text = data['workplace'];
        _qualificationController.text = data['occupation'];
      });
      print(name);
      print(phonenumber);
    }
  }

  void onEditManagerProfile() async {
    if (isManagerEditing) {
      // 사용자가 수정 완료 버튼을 눌렀을 때
      updateManagerProfile();
    } else {
      setState(() {
        isManagerEditing = true;
      });
    }
  }

  void updateManagerProfile() async {
    // 사용자가 수정 완료 버튼을 눌렀을 때
    final newData = {
      'occupation': _qualificationController.text,
      'workplace': _belongController.text,
    };

    try {
      final currentUser = 'OI75iw9Z1oTlV2EyyL8C'; // 현재 사용자 ID로 수정해야함
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser)
          .update(newData);

      // Firestore 업데이트 후 다시 사용자 정보 가져와서 화면 업데이트
      final updatedData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser)
          .get();
      Map<String, dynamic> updatedUserData =
          updatedData.data() as Map<String, dynamic>;

      setState(() {
        name = updatedUserData['managerName'];
        phonenumber = updatedUserData['phonenumber'];
        _belongController.text = updatedUserData['workplace'];
        _qualificationController.text = updatedUserData['occupation'];
        isManagerEditing = false; // '완료' 버튼 상태 업데이트
      });
    } catch (e) {
      print('데이터 업데이트 실패: $e');
    }
  }

  Future<void> onManagerLogout() async {
    // 로그아웃 구현
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signOut();
    } catch (e) {
      print('로그아웃 실패 오류 : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColor.myBackground,
      appBar: const ManagerAppBar(
        title: '메뉴',
        size: 95,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 450,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/images/user_profile.jpg",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 450,
              height: 180,
              decoration: BoxDecoration(
                color: MyColor.myWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    width: 450,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              "전화번호",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            //실제 이용자 전화번호
                            phonenumber,
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 0,
                    color: MyColor.myLightGrey,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    width: 450,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 200,
                            child: Text(
                              '자격',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _qualificationController,
                              style: const TextStyle(
                                fontSize: 22,
                                color: MyColor.myBlack,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                hintText: isManagerEditing
                                    ? "사회복지사 혹은 요양보호사"
                                    : _qualificationController.text,
                                hintStyle: const TextStyle(color: Colors.grey),
                              ),
                              enabled: isManagerEditing,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 0,
                    color: MyColor.myLightGrey,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(
                    width: 450,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 200,
                            child: Text(
                              "소속",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _belongController,
                              style: const TextStyle(
                                fontSize: 22,
                                color: MyColor.myBlack,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                hintText: isManagerEditing
                                    ? "OO센터"
                                    : _belongController.text,
                                hintStyle: const TextStyle(color: Colors.grey),
                              ),
                              enabled: isManagerEditing,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onEditManagerProfile,
              child: Container(
                width: 450,
                height: 60,
                decoration: BoxDecoration(
                  color: MyColor.myWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isManagerEditing
                          ? const Text(
                              "완료",
                              style: TextStyle(
                                  color: MyColor.myBlue,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            )
                          : const Text(
                              "정보 수정",
                              style: TextStyle(
                                  color: MyColor.myBlue,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onManagerLogout,
              child: Visibility(
                visible: !isManagerEditing,
                child: Container(
                  width: 450,
                  height: 60,
                  decoration: BoxDecoration(
                    color: MyColor.myWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "로그아웃",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                      ],
                    ),
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
