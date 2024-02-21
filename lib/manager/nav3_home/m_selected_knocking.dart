import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';
import 'package:knockknock/components/mybutton.dart';
import 'package:knockknock/components/mytitle.dart';
import 'package:knockknock/components/mypopup.dart';
import 'package:knockknock/manager/m_components/m_senior_profile_box.dart';
import 'package:knockknock/manager/manager_initial.dart';

class SelectedKnocking extends StatefulWidget {
  List<Map<String, dynamic>> seniorDocs;
  String manageruid;

  SelectedKnocking({
    Key? key,
    required this.seniorDocs,
    required this.manageruid,
  }) : super(key: key);

  @override
  State<SelectedKnocking> createState() => _SelectedKnockingState(
        seniorDocs: seniorDocs,
        manageruid: manageruid,
      );
}

class _SelectedKnockingState extends State<SelectedKnocking> {
  final List<Map<String, dynamic>> seniorDocs;
  final String manageruid;

  _SelectedKnockingState({
    Key? key,
    required this.seniorDocs,
    required this.manageruid,
  });

  late int numberofSeniors = seniorDocs.length;
  late ScrollController _scrollController;
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    isSelected = List.generate(numberofSeniors, (index) => false);
  }

  void onSelectAll() {
    setState(() {
      if (isSelected.contains(false)) {
        isSelected = List.generate(numberofSeniors, (index) => true);
      } else {
        isSelected = List.generate(numberofSeniors, (index) => false);
      }
    });
  }

  void onSelect(int index) {
    setState(() {
      isSelected[index] = !isSelected[index];
    });
  }

  void sendKnockMsg() async {
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i] == true) {
        await FirebaseFirestore.instance
            .collection('message')
            .doc(manageruid)
            .collection('senior')
            .doc(seniorDocs[i]['seniorUID'])
            .collection('now')
            .add({
          'context': "잘 지내시나요?",
          'date': Timestamp.now(),
          'writer_uid': manageruid,
        });
      }
    }
  }

  void onDone() {
    late String date;
    String msg = "";
    VoidCallback? donebuttonTapped;

    setState(() {
      if (isSelected.contains(true)) {
        sendKnockMsg();
        date = getCurrentDateTime();
        msg = "선택 문 두드리기 완료!";
        donebuttonTapped = () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManagerInitial(),
            ),
          );
        };
      } else {
        date = "선택된 사람이 없습니다 ";
        msg = "최소 한 명은 선택해주세요";
      }
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
              date: date,
              msg: msg,
              donebuttonTapped: donebuttonTapped,
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
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColor.myBackground,
      appBar: ManagerAppBar(
        size: 56,
        actionTap: onSelectAll,
        actionchild: const Text(
          "전체선택",
          style: TextStyle(
              color: MyColor.myBlue, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: double.maxFinite,
              height: 135,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyTitle(
                    title: '선택 문 두드리기',
                    explain: '두드릴 사람을 모두 선택하세요',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.maxFinite,
              height: 620,
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
                      bgColor: isSelected[index]
                          ? MyColor.myMediumGrey.withOpacity(0.6)
                          : Colors.white,
                      buttonTapped: () => onSelect(index),
                    );
                  },
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: double.maxFinite,
                height: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      text: '완료',
                      buttonColor: MyColor.myBlue,
                      txtColor: MyColor.myWhite,
                      buttonTapped: onDone,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
