import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';

class SeniorProfile extends StatefulWidget {
  final int index;
  const SeniorProfile({super.key, required this.index});

  @override
  State<SeniorProfile> createState() => _SeniorProfileState();
}

class _SeniorProfileState extends State<SeniorProfile> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _guardianController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  bool isSeniorEditing = false;

  void onEditSeniorProfile() {
    setState(() {
      isSeniorEditing = !isSeniorEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColor.myBackground,
      appBar: ManagerAppBar(
        size: 56,
        actionTap: onEditSeniorProfile,
        actionchild: isSeniorEditing
            ? const Text(
                "완료",
                style: TextStyle(
                    color: MyColor.myBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )
            : const Text(
                "편집",
                style: TextStyle(
                    color: MyColor.myBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 450,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 450,
                height: 240,
                decoration: BoxDecoration(
                  color: MyColor.myWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      width: 450,
                      height: 60,
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
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              width: 200,
                              child: Padding(
                                padding: EdgeInsets.only(top: 7),
                                child: Text(
                                  "주소",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _addressController,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: MyColor.myBlack,
                                ),

                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  hintText: isSeniorEditing ? "주소를 입력하세요" : "",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColor.myBlue),
                                  ),
                                ),
                                enabled:
                                    isSeniorEditing, // 추가: 편집 모드에 따라 편집 가능 여부 설정
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
                                "보호자 연락처",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _guardianController,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: MyColor.myBlack,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  hintText:
                                      isSeniorEditing ? "010-0000-0000" : "",
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColor.myBlue),
                                  ),
                                ),
                                enabled: isSeniorEditing,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 450,
                height: 300, // 기본 높이
                decoration: BoxDecoration(
                  color: MyColor.myWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      width: 450,
                      height: 60,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: Text(
                          "특이사항",
                          style: TextStyle(fontSize: 22),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        child: TextField(
                          controller: _specialityController,
                          style: const TextStyle(
                            fontSize: 22,
                            color: MyColor.myBlack,
                          ),
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: isSeniorEditing ? "내용을 수정하세요" : "",
                            hintStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: MyColor.myBlue),
                            ),
                          ),
                          enabled: isSeniorEditing,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
