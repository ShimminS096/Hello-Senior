import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/login_signup/i_login.dart';
import 'package:knockknock/login_signup/i_signup_manager.dart';
import 'package:knockknock/login_signup/i_signup_senior_matching.dart';

class SignUpChoose extends StatelessWidget {
  const SignUpChoose({super.key});

  void onChooseSenior(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SeniorMatching(),
      ),
    );
  }

  void onChooseManager(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ManagerSignUp(),
      ),
    );
  }

  void onToLoginClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColor.myBlue,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: MyColor.myBlue,
              automaticallyImplyLeading: false,
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
                    "회원가입",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () => onChooseSenior(context),
                  child: Container(
                    width: 400,
                    height: 200,
                    decoration: BoxDecoration(
                      color: MyColor.myWhite,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/person_icon.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 30),
                        const Text(
                          "돌봄 대상자",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: MyColor.myBlack,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => onChooseManager(context),
                  child: Container(
                    width: 400,
                    height: 200,
                    decoration: BoxDecoration(
                      color: MyColor.myWhite,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/person_icon.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 30),
                        const Text(
                          "관리자",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: MyColor.myBlack,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "이미 가입하셨다면? ",
                      style: TextStyle(
                        color: MyColor.myDarkGrey,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => onToLoginClicked(context),
                      child: const Text(
                        "로그인",
                        style: TextStyle(
                          color: MyColor.myBlue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
