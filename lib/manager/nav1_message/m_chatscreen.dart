import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';

import 'package:knockknock/manager/nav1_message/m_myside_chatbox.dart';
import 'package:knockknock/manager/nav1_message/m_otherside_chatbox.dart';

class ManagerChatscreen extends StatefulWidget {
  const ManagerChatscreen({super.key});

  @override
  State<ManagerChatscreen> createState() => _ManagerChatscreenState();
}

class _ManagerChatscreenState extends State<ManagerChatscreen> {
  // DB가 어떤 식으로 구성되는지 모르겠어서 일단은 리스트 형태로 더미 데이터 저장해놨습니다.. 추후 수정가능!!!!
  // 각각 관리 대상자마다 주고 받은 메세지 내용, 시간, isMe(관리자인지 나인지, 관리자가 나), isReply(두드리기에 답장 있는지)를 저장해야 함
  final List<String> messages = [
    'test',
    '약 드셨나요?',
    'Hello World',
    'test',
    '약 드셨나요?',
    'Hello World',
    'test',
    '약 드셨나요?',
    'Hello World'
  ];

  final List<String> timestamps = [
    "2024년 2월 9일 13시 20분",
    "2024년 2월 9일 13시 20분",
    "2024년 2월 9일 13시 20분",
    "2024년 2월 9일 13시 20분",
    "2024년 2월 13일 13시 20분",
    "2024년 2월 13일 13시 20분",
    "2024년 2월 13일 13시 20분",
    "2024년 2월 19일 13시 20분",
    "2024년 2월 29일 13시 20분",
  ];

  final List<bool> isMe = [
    false,
    true,
    true,
    false,
    true,
    false,
    false,
    true,
    false
  ];

  final List<bool> isReply = [
    false,
    true,
    true,
    false,
    false,
    false,
    false,
    true,
    false,
  ];

  late ScrollController _scrollController;
  late bool isWarning =
      false; // 답장없는게 있는지를 표현, isReply에 flse가 하나라도 있으면 자동으로 true로 세팅
  late String date = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    checkIsWarning();
  }

  void checkIsWarning() {
    if (isReply.contains(false)) {
      setState(() {
        isWarning = true;
      });
    } else {
      setState(() {
        isWarning = false;
      });
    }
  }

  bool printDate(String newDate) {
    return date != newDate;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.myBackground,
      appBar: const ManagerAppBar(
        size: 56,
      ),
      bottomNavigationBar: Container(
        color: MyColor.myBackground,
        height: 100,
        child: Center(
          child: Text(
            isWarning ? "⚠️ 6시간 이상 답이 없습니다 ⚠️" : "정상", // 멘트는 추후 적절하게 변경 예정
            style: TextStyle(
              fontSize: isWarning ? 28 : 25,
              color: isWarning ? MyColor.myRed : MyColor.myBlack,
              fontWeight: isWarning ? FontWeight.w800 : FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        trackVisibility: true,
        thumbVisibility: true,
        thickness: 5,
        radius: const Radius.circular(20),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: 9,
          itemBuilder: (context, index) {
            String newDate =
                timestamps[index].split(' ').sublist(0, 3).join(' ');

            if (printDate(newDate)) {
              // 날짜가 이전 것과 다른 경우는 날짜 + 채팅 박스 출력
              date = newDate;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        newDate,
                        style: const TextStyle(
                          color: MyColor.myDarkGrey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  isMe[index]
                      ? Padding(
                          // isMe가 true이면 MySideChatBox
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: MySideChatBox(
                            message: messages[index],
                            time: timestamps[index]
                                .split(' ')
                                .sublist(3)
                                .join(' '),
                            isReply: isReply[index],
                          ),
                        )
                      : Padding(
                          // isMe가 false이면 OtherSideChatBox
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: OtherSideChatBox(
                            name: "name",
                            message: messages[index],
                            time: timestamps[index]
                                .split(' ')
                                .sublist(3)
                                .join(' '),
                            profile: "assets/images/user_profile.jpg",
                          ),
                        ),
                ],
              );
            } else {
              // 날짜가 이전 것과 그대로인 경우는 채팅 박스만 출력
              return isMe[index]
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: MySideChatBox(
                        message: messages[index],
                        time: timestamps[index].split(' ').sublist(3).join(' '),
                        isReply: isReply[index],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: OtherSideChatBox(
                        name: "name",
                        message: messages[index],
                        time: timestamps[index].split(' ').sublist(3).join(' '),
                        profile: "assets/images/user_profile.jpg",
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}
