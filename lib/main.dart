import 'package:flutter/material.dart';
import 'package:knockknock/login_signup/i_login.dart';
import 'package:knockknock/manager/manager_initial.dart';
import 'package:knockknock/manager/nav2_todo/m_todo_initial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:knockknock/senior/senior.inital.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: Login(),
      // home: ManagerInitial(),
      // home: SeniorInitial(),
    );
  }
}
