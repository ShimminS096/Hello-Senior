import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class MyTitle extends StatelessWidget {
  final String title;
  final String explain;

  const MyTitle({super.key, required this.title, required this.explain});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: MyColor.myBlack,
            fontSize: 38,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          explain,
          style: const TextStyle(
            color: MyColor.myDarkGrey,
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
