import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class OtherSideChatBox extends StatelessWidget {
  const OtherSideChatBox({
    Key? key,
    required this.name,
    required this.profile,
    required this.message,
    required this.time,
  }) : super(key: key);

  final String name;
  final String profile;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            profile,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: MyColor.myDarkGrey,
                    fontSize: 22,
                  ),
                ),
                Container(
                  width: 220,
                  height: 100,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: MyColor.myWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: MyColor.myBlack,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Text(
              time,
              style: const TextStyle(
                color: MyColor.myDarkGrey,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
