import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class LocationBox extends StatelessWidget {
  final String name;
  final Color? bgColor;
  final VoidCallback buttonTapped;

  const LocationBox(
      {super.key,
      required this.name,
      this.bgColor,
      required this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        width: 50,
        height: 15,
        decoration: BoxDecoration(
          color: bgColor ?? MyColor.myWhite,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: MyColor.myBlue,
              ),
              const SizedBox(width: 5),
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
