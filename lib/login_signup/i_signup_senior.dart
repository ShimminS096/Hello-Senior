import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/login_signup/i_input_form.dart';
import 'package:knockknock/login_signup/i_login.dart';
import 'package:knockknock/login_signup/i_signup_choose.dart';
import 'package:knockknock/components/mybutton.dart';
import 'package:knockknock/components/mytitle.dart';
import 'package:knockknock/components/mypopup.dart';

class SeniorSignUp extends StatefulWidget {
  final String managerUID;

  const SeniorSignUp({Key? key, required this.managerUID}) : super(key: key);

  @override
  State<SeniorSignUp> createState() => _SeniorSignUpState(managerUID);
}

class _SeniorSignUpState extends State<SeniorSignUp> {
  //1단계에서 넘겨받은 관리자 UID
  final String managerUID;
  _SeniorSignUpState(this.managerUID);

  //2단계에서 입력받는 정보
  bool isAskAuth = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _authController = TextEditingController();
  String seniorUID = "";

  void onSettingProfile() {
    // 프로필 이미지를 설정하는 기능
  }

  void onSeniorSignUpCancel(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpChoose(),
      ),
    );
  }

  void onSeniorSignUpDone(BuildContext context) {
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
      // 인증(로그인) 구현 필요
      // 예를 들어, 서버로 인증번호 확인 요청 등
      _signUpWithEmailAndPassword(context);
      showDialog(
        context: context,
        builder: ((context) {
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
                      builder: (context) => Login(),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      );
    }
  }

  //회원 가입 기능
  Future<void> _signUpWithEmailAndPassword(BuildContext context) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _phoneController.text + '@knockknock.com',
            password: _phoneController.text);

    seniorUID = userCredential.user!.uid;
    //firestore의 users 컬렉션에 신규 시니어 문서 등록하기
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'seniorUID': seniorUID,
      'phoneNumber': _phoneController.text,
      'seniorName': _nameController.text,
      'role': "senior",
      'address': "",
      'detail': "",
      'protectorPhoneNumber': "",
      'managerUID': managerUID,
    });

    //firestore의 message 컬렉션에 신규 시니어 문서 등록하기
    await FirebaseFirestore.instance
        .collection('message')
        .doc(managerUID)
        .collection('senior')
        .doc(userCredential.user!.uid)
        .set({
      'name': _nameController.text,
      'uid': seniorUID,
    });

    //firestore의 todo_list 컬렉션에 신규 시니어 문서 등록하기
    await FirebaseFirestore.instance
        .collection('todo_list')
        .doc(managerUID)
        .collection(userCredential.user!.uid)
        .doc('todos')
        .set({
      'todo': [],
    });

    //firestore의 location 컬렉션에 신규 시니어 문서 등록하기
    await FirebaseFirestore.instance
        .collection('location')
        .doc(userCredential.user!.uid)
        .set({
      'CurrentLocation': "",
      'LatLng': [0, 0], //location 로직을 몰라서 완벽하지 않음
      'SeniorName': _nameController.text,
    });

    // Firestore에서 회원 가입된 신규 시니어와 매칭된 관리자 문서에 대한 참조를 얻음
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(managerUID);

    // 문서의 필드를 갱신
    await documentReference.update({
      'seniorUIDs': FieldValue.arrayUnion([seniorUID])
    });
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                    child: MyTitle(
                      title: '2단계. 회원가입',
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
                        buttonTapped: () => onSeniorSignUpCancel(context),
                      ),
                      const SizedBox(height: 10),
                      MyButton(
                        width: 400,
                        text: '완료',
                        buttonColor: MyColor.myBlue,
                        txtColor: MyColor.myWhite,
                        buttonTapped: () => onSeniorSignUpDone(context),
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
