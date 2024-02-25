import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class MySideChatBox extends StatelessWidget {
  const MySideChatBox({
    Key? key,
    required this.message,
    required this.time,
    required this.isReply,
  }) : super(key: key);

  final String message;
  final String time;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          time,
          style: const TextStyle(
            color: MyColor.myDarkGrey,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 250,
          height: 100,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isReply ? MyColor.myBlue : MyColor.myRed,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              message,
              style: const TextStyle(
                color: MyColor.myWhite,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
