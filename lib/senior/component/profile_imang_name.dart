import 'package:flutter/material.dart';

class ProfileImageName extends StatelessWidget {
  const ProfileImageName({
    super.key,
    required this.photo,
    required this.name,
  });

  final String photo;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Image.asset(
            photo,
            height: 180,
            width: 180,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
