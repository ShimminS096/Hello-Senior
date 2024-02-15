import 'package:flutter/material.dart';
import 'package:knockknock/login_signup/i_login.dart';
import 'package:knockknock/senior/senior.inital.dart';

void main() {
  runApp(const KnockKnock());
}

class KnockKnock extends StatefulWidget {
  const KnockKnock({Key? key}) : super(key: key);

  @override
  State<KnockKnock> createState() => _KnockKnockState();
}

class _KnockKnockState extends State<KnockKnock> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
        // home: SeniorInitial()
        // home: ManagerInitial(),
        );
  }
}
