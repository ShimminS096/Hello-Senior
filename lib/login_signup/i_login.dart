import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/login_signup/i_input_form.dart';
import 'package:knockknock/login_signup/i_signup_choose.dart';
import 'package:knockknock/components/mybutton.dart';
import 'package:knockknock/components/mypopup.dart';
import 'package:knockknock/manager/manager_initial.dart';
import 'package:knockknock/senior/senior.inital.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isAskAuth = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _authController = TextEditingController();

  void onAskAuth(BuildContext context) {
    if (_phoneController.text.isEmpty) {
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
                msg: "전화번호를 입력하세요",
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

  void onLoginClicked(BuildContext context) {
    if (_authController.text.isEmpty) {
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
    } else {
      // 인증(로그인) 구현 필요
      // 예를 들어, 서버로 인증번호 확인 요청 등

      Navigator.push(
        // 정상적으로 로그인 되면 시니어, 혹은 관리자 홈으로 이동
        // 시니어인지 관리자인지 확인 필요
        context,
        MaterialPageRoute(
          // builder: (context) => const ManagerInitial(),
          builder: (context) => SeniorInitial(),
        ),
      );
    }
  }

  void onToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpChoose(),
      ),
    );
  }

  void onGoogleLogin() {
    // 구글 로그인 구현
  }

  void onForgetPassword() {
    // (선택) 비밀번호 찾기 구현
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: MyColor.myBlue,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(250),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: MyColor.myBlue,
                title: const Center(
                  child: Text(
                    "KNOCKKNOCK!",
                    style: TextStyle(
                      color: MyColor.myWhite,
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: MyColor.myBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 400,
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 30),
                  InputForm(title: "전화번호", controller: _phoneController),
                  isAskAuth
                      ? Column(
                          children: [
                            const SizedBox(height: 30),
                            InputForm(
                                title: "인증번호", controller: _authController),
                            const SizedBox(height: 45),
                            MyButton(
                              width: 400,
                              buttonColor: MyColor.myBlue,
                              text: "확인",
                              txtColor: Colors.white,
                              buttonTapped: () => onLoginClicked(context),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 45),
                            MyButton(
                              width: 400,
                              buttonColor: MyColor.myBlue,
                              text: "인증번호 요청",
                              txtColor: Colors.white,
                              buttonTapped: () => onAskAuth(context),
                            ),
                          ],
                        ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: onForgetPassword,
                          child: const Text(
                            "비밀번호 찾기",
                            style: TextStyle(
                              color: MyColor.myDarkGrey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => onToSignUp(context),
                          child: const Text(
                            "회원가입",
                            style: TextStyle(
                              color: MyColor.myBlue,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(
                    width: 400,
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(color: MyColor.myDarkGrey),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "또는",
                            style: TextStyle(
                              color: MyColor.myDarkGrey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: MyColor.myDarkGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: onGoogleLogin,
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/google.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "구글 계정으로 간편 로그인",
                          style: TextStyle(
                            color: MyColor.myDarkGrey,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}