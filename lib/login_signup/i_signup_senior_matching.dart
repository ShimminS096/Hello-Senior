import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/login_signup/i_input_form.dart';
import 'package:knockknock/login_signup/i_signup_senior.dart';
import 'package:knockknock/components/mybutton.dart';
import 'package:knockknock/components/mytitle.dart';
import 'package:knockknock/components/mypopup.dart';

class SeniorMatching extends StatefulWidget {
  const SeniorMatching({Key? key}) : super(key: key);

  @override
  State<SeniorMatching> createState() => _SeniorMatchingState();
}

class _SeniorMatchingState extends State<SeniorMatching> {
  void onConnectClicked() {
    if (_managernameController.text.isEmpty || // 한 칸이라도 빈 칸이 있으면 오류 팝업
        _managerPhoneController.text.isEmpty) {
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
      // 연결 처리 로직 추가
      setState(() {
        isConnecting = true; // 연결 완료되면 true로 변경
      });
    }
  }

  void onMatchingDone() {
    if (isConnecting) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SeniorSignUp(),
        ),
      );
    }
  }

  bool isConnecting = false;

  final TextEditingController _managernameController = TextEditingController();
  final TextEditingController _managerPhoneController = TextEditingController();

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
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
                child: MyTitle(
                  title: '1단계. 관리자 매칭',
                  explain: '담당 관리자의 정보를 입력하세요',
                ),
              ),
              const SizedBox(height: 40),
              Image.asset(
                "assets/images/matching.png",
                width: 380,
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 50),
              InputForm(title: "관리자 이름", controller: _managernameController),
              const SizedBox(height: 55),
              InputForm(title: "관리자 전화번호", controller: _managerPhoneController),
              const SizedBox(height: 75),
              MyButton(
                width: 400,
                text: isConnecting ? '연결 완료' : '연결',
                buttonColor:
                    isConnecting ? MyColor.myLightGrey : MyColor.myBlue,
                txtColor: isConnecting ? MyColor.myMediumGrey : MyColor.myWhite,
                buttonTapped: onConnectClicked,
              ),
              const SizedBox(height: 10),
              MyButton(
                  width: 400,
                  text: '다음',
                  buttonColor:
                      isConnecting ? MyColor.myBlue : MyColor.myLightGrey,
                  txtColor:
                      isConnecting ? MyColor.myWhite : MyColor.myMediumGrey,
                  buttonTapped: onMatchingDone),
            ],
          ),
        ),
      ),
    );
  }
}
