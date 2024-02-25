import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class SeniorProfileBox extends StatelessWidget {
  final String photo;
  final String name;
  final Color? bgColor;
  final VoidCallback buttonTapped;

  const SeniorProfileBox(
      {super.key,
      required this.photo,
      required this.name,
      this.bgColor,
      required this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        width: 214,
        height: 214,
        decoration: BoxDecoration(
          color: bgColor ?? MyColor.myWhite,
          borderRadius: BorderRadius.circular(60),
          // border: Border.all(color: MyColor.myLightGrey, width: 1),
          // boxShadow: const [
          //   BoxShadow(
          //     color: MyColor.myLightGrey,
          //     //color: Colors.red,
          //     spreadRadius: 1,
          //     blurRadius: 5,
          //     offset: Offset(3, 3), // changes position of shadow
          //   ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                photo,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25)
                //  style: Theme.of(context).textTheme.bodyLarge
                ),
          ],
        ),
      ),
    );
  }
}
