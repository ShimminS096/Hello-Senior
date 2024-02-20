import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';
import 'package:knockknock/components/mybutton.dart';
import 'package:knockknock/components/mypopup.dart';
import 'package:knockknock/manager/m_components/m_senior_profile_box.dart';
import 'package:knockknock/manager/nav3_home/m_selected_knocking.dart';
import 'package:knockknock/manager/nav3_home/m_senior_profile.dart';
import 'package:knockknock/manager/nav3_home/m_senior_profile.dart';

class ManagerHomeInitial extends StatefulWidget {
  const ManagerHomeInitial({super.key});

  @override
  State<ManagerHomeInitial> createState() => _ManagerHomeInitialState();
}

class _ManagerHomeInitialState extends State<ManagerHomeInitial> {
  String manageruid = "OI75iw9Z1oTlV2EyyL8C"; //[하드코딩] 임시로 관리자 uid 넣어줌
  List<Map<String, dynamic>> seniorDocs = [];
  int numberofSeniors = 0; // 현재 유저의 id를 manageruid로 가진 유저의 수

  /*
  manageruid가 현재 유저(관리자)와 같은 돌봄 관리자 문서를 전부 가져오기
  */
  Future<void> fetchSeniorDocs() async {
    QuerySnapshot seniorInfoSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('managerUID', isEqualTo: manageruid)
        .where('role', isEqualTo: 'senior')
        .get();

    //seniorDocs 리스트에 가져온 문서들을 하나씩 저장하기
    seniorDocs = seniorInfoSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    //현재 상태로 갱신하기
    setState(() {
      seniorDocs = seniorDocs;
      numberofSeniors = seniorDocs.length;
    });
  }

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchSeniorDocs();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void onSeniorProfileBoxClicked(Map<String, dynamic> seniorInfo, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SeniorProfile(seniorInfo: seniorInfo, index: index),
      ),
    );
  }

  void onselectedNocking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectedKnocking(
          seniorDocs: seniorDocs,
          manageruid: manageruid,
        ),
      ),
    );
  }

  // 💛 전체 문 두드리기
  void onAllNocking() {
    /*
    message 컬렉션에 "잘 지내시나요?" 메세지 보내기
    */
    seniorDocs.forEach((info) async {
      await FirebaseFirestore.instance
          .collection('message')
          .doc(manageruid)
          .collection('senior')
          .doc(info['uid'])
          .collection('now')
          .add({
        'context': "잘 지내시나요?",
        'date': Timestamp.now(),
        'writer_uid': manageruid,
      });
    });

    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
          ),
          actions: [
            MyPopUp(
              date: getCurrentDateTime(),
              msg: "전체 문 두드리기 완료!",
            ),
          ],
        );
      }),
    );
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();

    int year = now.year;
    int month = now.month;
    int day = now.day;
    int hour = now.hour;
    int minute = now.minute;

    return '$year년 $month월 $day일 $hour시 $minute분';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColor.myBackground,
      appBar: const ManagerAppBar(
        size: 95,
        title: '홈',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 630,
              child: Scrollbar(
                controller: _scrollController,
                trackVisibility: true,
                thumbVisibility: true,
                thickness: 5,
                radius: const Radius.circular(20),
                child: GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  shrinkWrap: true,
                  itemCount: numberofSeniors,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return SeniorProfileBox(
                      photo: 'assets/images/user_profile.jpg',
                      name: seniorDocs[index]['seniorName'],
                      bgColor: MyColor.myWhite,
                      buttonTapped: () =>
                          onSeniorProfileBoxClicked(seniorDocs[index], index),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    text: '선택 문 두드리기',
                    buttonColor: MyColor.myMediumGrey,
                    txtColor: MyColor.myBlack,
                    buttonTapped: onselectedNocking,
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    text: '전체 문 두드리기',
                    buttonColor: MyColor.myBlue,
                    txtColor: MyColor.myWhite,
                    buttonTapped: onAllNocking,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
