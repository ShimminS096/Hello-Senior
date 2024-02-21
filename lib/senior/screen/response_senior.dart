import 'package:flutter/material.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/screen/response_2_senior.dart';
import 'package:knockknock/senior/screen/home_senior.dart';
import 'package:knockknock/senior/screen/emergency_senior.dart';
import 'package:knockknock/senior/screen/record_senior.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ResponsePage extends StatefulWidget {
  final String manageruid;
  final String senioruid;
  final String seniorName;
  final String managerName;
  final String managerOccupation;

  ResponsePage({
    Key? key,
    required this.senioruid,
    required this.seniorName,
    required this.manageruid,
    required this.managerName,
    required this.managerOccupation,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResponsePage(
        senioruid: senioruid,
        seniorName: seniorName,
        manageruid: manageruid,
        managerName: managerName,
        managerOccupation: managerOccupation,
      );
}

class _ResponsePage extends State<ResponsePage> {
  String manageruid;
  String senioruid;
  String seniorName;
  String managerName;
  String managerOccupation;

  _ResponsePage({
    Key? key,
    required this.senioruid,
    required this.seniorName,
    required this.manageruid,
    required this.managerName,
    required this.managerOccupation,
  });

  void goBack() {}

  bool isKnocked = false; // 대화 내역 없음[디폴트]

  String knockTime = '';
  String lastResponseTime = '';

  late QuerySnapshot seniorMsgSnapshot; // 컬렉션 이동용

  int _selectedIndex = 0;
  List<Widget> _navIndex = [
    RecordPage(),
    const HomePage(),
    const EmergencyPage(),
  ];
  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void fetchKnockMessage() async {
    /*
    ["users" 컬렉션 > '현재 돌봄 대상자 문서] 가져오기
    */
    DocumentSnapshot seniorInfoSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(senioruid)
        .get();

    /* 
    현재 돌봄 대상자 문서의 정보를 data 라는 Map에 필드별로 넣기 & 정보 가져오기
    */
    Map<String, dynamic> data =
        seniorInfoSnapshot.data() as Map<String, dynamic>;

    seniorName = data['seniorName'];
    manageruid = data['managerUID'];

    /*
    ["users" 컬렉션 > '현재 돌봄 대상자 문서] 가져오기
    */
    DocumentSnapshot managerInfoSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(manageruid)
        .get();

    /* 
    현재 돌봄 대상자 문서의 정보를 data 라는 Map에 필드별로 넣기 & 정보 가져오기
    */
    Map<String, dynamic> managerdata =
        managerInfoSnapshot.data() as Map<String, dynamic>;

    managerName = managerdata['managerName'];
    managerOccupation = managerdata['occupation'];

    /*
    [message" 컬렉션 > 현재 관리자 문서 > "senior" 컬렉션 > 현재 돌봄 대상자 문서] 가져오기
    */
    seniorMsgSnapshot = await FirebaseFirestore.instance
        .collection('message')
        .doc(manageruid)
        .collection('senior')
        .doc(senioruid)
        .collection('now')
        .orderBy('date', descending: true)
        .get();

    //만약 context에 담긴 내용이 'NEW_CREATE'

    QuerySnapshot seniorCheckedMsgSnapshot = await FirebaseFirestore.instance
        .collection('message')
        .doc(manageruid)
        .collection('senior')
        .doc(senioruid)
        .collection('checked')
        .orderBy('date', descending: true)
        .get();

    /* 
    현재 돌봄 대상자 문서의 정보를 data 라는 Map에 필드별로 넣기 & 정보 가져오기
    */
    if (seniorMsgSnapshot.docs.isEmpty) {
      isKnocked = false;
    } else {
      isKnocked = true;

      DocumentSnapshot msg = seniorMsgSnapshot.docs.first;
      Map<String, dynamic> msgdata = msg.data() as Map<String, dynamic>;
      knockTime =
          DateFormat('yyyy년 MM월 dd일 hh시 mm분').format(msgdata['date'].toDate());
    }

    if (seniorCheckedMsgSnapshot.docs.isEmpty) {
      lastResponseTime = "문두드리기 내역이 없습니다.";
    } else {
      Map<String, dynamic> checkedmsgdata =
          seniorCheckedMsgSnapshot.docs.first.data() as Map<String, dynamic>;
      lastResponseTime = DateFormat('yyyy년 MM월 dd일 hh시 mm분')
          .format(checkedmsgdata['date'].toDate());
    }
    setState(() {
      this.isKnocked = isKnocked;
      this.knockTime = knockTime;
      this.lastResponseTime = lastResponseTime;
      this.managerName = managerName;
      this.seniorName = seniorName;
      this.managerOccupation = managerOccupation;
      this.manageruid = manageruid;
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchKnockMessage();
    if (!isKnocked) {
      return DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: _selectedIndex == 2
                ? const Color(0xffeeccca)
                : const Color(0xffEDEDF4),
            body: _navIndex[_selectedIndex],
          ));
    } else {
      return Scaffold(
        appBar: const MyAppBar(
          myLeadingWidth: 130,
        ),
        body: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFEDEDF4)),
          //배경
          child: Stack(
            children: [
              //사회복지사 프로필+이름
              Positioned(
                left: 0,
                right: 0,
                top: 50,
                child: Container(
                  width: 354,
                  height: 250,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/basic_profile.png'),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 170,
                        child: SizedBox(
                          child: Text(
                            managerName + ' ' + managerOccupation,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 30,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0.06,
                              letterSpacing: -0.53,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //'잘 계시나요?' 박스
              Positioned(
                  left: 40,
                  right: 40,
                  top: 270,
                  child: Container(
                    width: 30,
                    height: 200,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                            color: const Color.fromARGB(255, 206, 206, 206),
                            width: 3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        knockTime + '\n' + seniorName + ' 님\n잘 계시나요?',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              // 마지막 대답 날짜
              Positioned(
                left: 35,
                right: 35,
                top: 600,
                child: SizedBox(
                  width: 325,
                  height: 200,
                  child: Text(
                    '마지막 대답 날짜:\n${lastResponseTime}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1,
                      letterSpacing: -0.53,
                    ),
                  ),
                ),
              ),
              // 대답하기 버튼
              Positioned(
                left: 35,
                right: 35,
                top: 500,
                child: OutlinedButton(
                  onPressed: () async {
                    // "now" 컬렉션의 모든 문서를 "checked" 컬렉션으로 옮기기
                    List<Map<String, dynamic>> answeredData = seniorMsgSnapshot
                        .docs
                        .map((doc) => doc.data() as Map<String, dynamic>)
                        .toList();

                    answeredData.forEach((data) async {
                      await FirebaseFirestore.instance
                          .collection('message')
                          .doc(manageruid)
                          .collection('senior')
                          .doc(senioruid)
                          .collection('checked')
                          .add({
                        'context': data['context'],
                        'date': data['date'],
                        'writer_uid': data['writer_uid'],
                      });
                    });

                    // "now" 컬렉션의 모든 문서 제거하기
                    seniorMsgSnapshot.docs.forEach((uselessMsg) async {
                      await uselessMsg.reference.delete();
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResponseCompletePage(
                            manageruid: manageruid,
                            managerName: managerName,
                            managerOccupation: managerOccupation,
                            senioruid: senioruid, // seniorData에서 uid 가져오기
                          ),
                        ));
                  },
                  child: const Text(
                    '대답하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(333, 83),
                    backgroundColor: Color(0xFF3475EB),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60))),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
