import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/login_signup/i_input_form.dart';
import 'package:knockknock/login_signup/i_login.dart';
import 'package:knockknock/login_signup/i_signup_choose.dart';
import 'package:knockknock/components/mybutton.dart';
import 'package:knockknock/components/mytitle.dart';
import 'package:knockknock/components/mypopup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManagerSignUp extends StatefulWidget {
  const ManagerSignUp({super.key});

  @override
  State<ManagerSignUp> createState() => _ManagerSignUpState();
}

class _ManagerSignUpState extends State<ManagerSignUp> {
  bool isAskAuth = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _authController = TextEditingController();

  void onSettingProfile() {
    // 프로필 이미지를 설정하는 기능
  }
  void onAskAuth(BuildContext context) {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      showDialog(
        context: context,
        builder: ((context) {
          return const AlertDialog(
            actionsPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(60)),
            ),
            actions: [
              MyPopUp(
                date: "입력 오류",
                msg: "모든 입력란을 채워주세요",
              ),
            ],
          );
        }),
      );
    } else {
      setState(() {
        // 인증 요청
        isAskAuth = true;
      });
    }
  }

  //회원 가입 기능
  Future<void> _signUpWithEmailAndPassword(BuildContext context) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _phoneController.text + '@knockknock.com',
            password: _phoneController.text);

    //firestore의 users 컬렉션에 신규 관리자 문서 등록하기
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'mangerUID': userCredential.user!.uid,
      'phoneNumber': _phoneController.text,
      'managerName': _nameController.text,
      'occupation': "",
      'workplace': "",
      'seniorUIDs': [],
      'role': "manager",
    });
  }

  void onManagerSignUpCancel(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpChoose(),
      ),
    );
  }

  void onManagerSignUpDone(BuildContext context) {
    showDialog(
      context: context,
      builder: ((context) {
        return const AlertDialog(
          actionsPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
          ),
          actions: [
            MyPopUp(
              date: "입력 오류",
              msg: "인증번호를 입력하세요",
            ),
          ],
        );
      }),
    );

    // 인증(로그인) 구현 필요
    // 예를 들어, 서버로 인증번호 확인 요청 등

    showDialog(
      // 회원가입이 정상적으로 완료되었을 때 띄울 팝업
      context: context,
      builder: ((context) {
        _signUpWithEmailAndPassword(context);
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
          ),
          actions: [
            MyPopUp(
              date: "회원가입 완료",
              msg: "확인을 눌러 로그인하러 가기",
              donebuttonTapped: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColor.myBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 30),
        scrolledUnderElevation: 0,
        backgroundColor: MyColor.myBackground,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                    child: MyTitle(
                      title: '관리자 회원가입',
                      explain: '모든 항목을 입력하세요',
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: onSettingProfile,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/basic_profile.png",
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InputForm(title: "이름", controller: _nameController),
                  const SizedBox(height: 40),
                  InputForm(title: "전화번호", controller: _phoneController),
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      MyButton(
                        width: 400,
                        text: '취소',
                        buttonColor: MyColor.myMediumGrey,
                        txtColor: MyColor.myBlack,
                        buttonTapped: () => onManagerSignUpCancel(context),
                      ),
                      const SizedBox(height: 10),
                      MyButton(
                        width: 400,
                        text: '완료',
                        buttonColor: MyColor.myBlue,
                        txtColor: MyColor.myWhite,
                        buttonTapped: () => onManagerSignUpDone(context),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
