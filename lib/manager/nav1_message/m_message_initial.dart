import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';
import 'package:knockknock/manager/nav1_message/m_chatscreen.dart';
import 'package:knockknock/manager/nav1_message/m_message_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerMessageInitial extends StatefulWidget {
  final String managerid = "OI75iw9Z1oTlV2EyyL8C"; //임시로 관리자 uid 넣어줌
  const ManagerMessageInitial({super.key});

  @override
  State<ManagerMessageInitial> createState() =>
      _ManagerMessageInitialState(managerid: managerid);
}

class _ManagerMessageInitialState extends State<ManagerMessageInitial> {
  final String managerid;

  _ManagerMessageInitialState({
    Key? key,
    required this.managerid,
  });

  String seniorname = "";
  String seniorid = "";

  List<Map<String, dynamic>> seniorDocs = [];
  List<String> msg = [];

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    fetchSeniorDocs(); //firestore에서 현재 관리자의 전체 메세지 내역 가져오기
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchSeniorDocs() async {
    try {
      //senior 컬렉션의 전체 문서 가져오기
      QuerySnapshot seniorsnapshot = await FirebaseFirestore.instance
          .collection('message')
          .doc(managerid)
          .collection('senior')
          .get();

      //seniorDocs 리스트에 가져온 문서들을 하나씩 저장하기

      seniorDocs = seniorsnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      //개별 문서에 담겨있는 seniorname, seniorid, 메세지를 가져오기
      for (var seniorData in seniorDocs) {
        List<Map<String, dynamic>> msgDocs = [];
        List<Map<String, dynamic>> nowmsgDocs = [];
        seniorname = seniorData['name']?.toString() ?? 'Unknown';
        seniorid = seniorData['uid'];

        //위에서 선택한 서브컬렉션(now || checked) 컬렉션의 전체 문서 가져오기
        QuerySnapshot msgSnapshot = await FirebaseFirestore.instance
            .collection('message')
            .doc(widget.managerid)
            .collection('senior')
            .doc(seniorid)
            .collection('now')
            .orderBy('date', descending: false)
            .get();

        //msgDocs라는 리스트에 가져온 문서들을 하나씩 저장하기
        msgDocs = msgSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        QuerySnapshot nowmsgSnapshot = await FirebaseFirestore.instance
            .collection('message')
            .doc(widget.managerid)
            .collection('senior')
            .doc(seniorid)
            .collection('checked')
            .orderBy('date', descending: false)
            .get();

        //msgDocs라는 리스트에 가져온 문서들을 하나씩 저장하기
        nowmsgDocs = nowmsgSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        //만약 서브컬랙션에 문서가 존재할 경우, 가장 최신 메세지 문서의 메세지 내용(context) 가져오기
        if (msgDocs.isNotEmpty) {
          msg.add(msgSnapshot.docs.first['context'].toString());
        } else if (nowmsgDocs.isNotEmpty) {
          msg.add(nowmsgSnapshot.docs.last['context'].toString());
        } else {
          //만약 서브컬랙션에 문서가 존재하지 않을 경우, 디폴트 내역 넣기
          msg.add("메세지 내역이 없습니다.");
        }
      }
    } catch (e) {
      print("error");
    }

    setState(() {
      this.msg = msg;
    });
  }

  void onMessagePreviewClicked(int index, String name, String uid) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SeniorProfile(index: index),
    //   ),
    // );
    Navigator.push(
        context,
        MaterialPageRoute(
          //개별 메세지창으로 이동하려면, managerid, seniorid, seniorname 필요
          builder: (context) => ManagerChatscreen(
            managerid: managerid,
            seniorid: uid, // seniorData에서 uid 가져오기
            seniorname: name,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    //fetchSeniorDocs(); //firestore에서 현재 관리자의 전체 메세지 내역 가져오기
    return Scaffold(
      backgroundColor: MyColor.myBackground,
      appBar: const ManagerAppBar(
        title: '메세지',
        size: 95,
      ),
      body: Scrollbar(
        controller: _scrollController,
        trackVisibility: true,
        thumbVisibility: true,
        thickness: 5,
        radius: const Radius.circular(20),
        child: ListView.separated(
          controller: _scrollController,
          itemCount: seniorDocs.length,
          separatorBuilder: (context, index) => const Divider(
            height: 0,
            indent: 20,
            endIndent: 20,
            color: MyColor.myMediumGrey,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ManagerMessagePreview(
                  // index를 통해 프로필 사진, 이름, 가장 최근 메세지를 받아서 미리보기를 출력
                  photo: 'assets/images/user_profile.jpg',
                  name: seniorDocs[index]['name'],
                  latest: msg[index],
                  // 개별 메세지 widget을 선택했을 때 넘겨줘야 하는 값
                  previewTapped: () => onMessagePreviewClicked(index,
                      seniorDocs[index]['name'], seniorDocs[index]['uid']),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
