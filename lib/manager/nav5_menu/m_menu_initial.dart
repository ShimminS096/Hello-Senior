import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';

class ManagerMenuInitial extends StatefulWidget {
  const ManagerMenuInitial({super.key});

  @override
  State<ManagerMenuInitial> createState() => _ManagerMenuInitialState();
}

class _ManagerMenuInitialState extends State<ManagerMenuInitial> {
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _belongController = TextEditingController();

  bool isManagerEditing = false;

  void onEditManagerProfile() {
    setState(() {
      isManagerEditing = !isManagerEditing;
    });
  }

  void onManagerLogout() {
    // 로그아웃 구현 필요
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
                  const Text(
                    "홍길동",
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
                    child: const Padding(
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
                            "010-0000-0000",
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
                                hintText:
                                    isManagerEditing ? "010-0000-0000" : "",
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
                                hintText:
                                    isManagerEditing ? "010-0000-0000" : "",
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
