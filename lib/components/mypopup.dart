import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class MyPopUp extends StatelessWidget {
  final String date;
  final String msg;
  final VoidCallback? donebuttonTapped;

  const MyPopUp({
    super.key,
    required this.date,
    required this.msg,
    this.donebuttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 300,
      decoration: BoxDecoration(
        color: MyColor.myWhite,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            date,
            style: const TextStyle(
              color: MyColor.myBlack,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            msg,
            style: const TextStyle(
              color: MyColor.myBlack,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              if (donebuttonTapped != null) {
                donebuttonTapped!();
              }
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: MyColor.myBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  "확인",
                  style: TextStyle(
                    color: MyColor.myWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
