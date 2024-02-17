import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:knockknock/login_signup/i_login.dart';
import 'package:knockknock/senior/senior.inital.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        // home: Login(),
        home: SeniorInitial()
        // home: ManagerInitial(),
        );
  }
}
