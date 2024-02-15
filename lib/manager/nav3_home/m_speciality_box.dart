import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class SpecialityBox extends StatefulWidget {
  const SpecialityBox({
    Key? key,
  }) : super(key: key);

  @override
  State<SpecialityBox> createState() => _SpecialityBoxState();
}

class _SpecialityBoxState extends State<SpecialityBox> {
  final TextEditingController _specialityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 350, // 기본 높이
      decoration: BoxDecoration(
        color: MyColor.myWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Text(
              "특이사항",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            height: 0,
            color: MyColor.myLightGrey,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: TextField(
                controller: _specialityController,
                style: const TextStyle(fontSize: 22),
                maxLines: null,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: "내용을 수정하세요",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
