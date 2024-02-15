import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';
import 'package:knockknock/manager/nav1_message/m_chatscreen.dart';
import 'package:knockknock/manager/nav1_message/m_message_preview.dart';

class ManagerMessageInitial extends StatefulWidget {
    final int numberofSeniors;
  const ManagerMessageInitial({super.key, required this.numberofSeniors});

  @override
  State<ManagerMessageInitial> createState() => _ManagerMessageInitialState();
}

class _ManagerMessageInitialState extends State<ManagerMessageInitial> {
  final int numberofSeniors = 10;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onMessagePreviewClicked(int index) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SeniorProfile(index: index),
    //   ),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ManagerChatscreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          itemCount: numberofSeniors,
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
                  // 각가 프로필 사진, 이름, 가장 최근 메세지를 받아서 미리보기를 출력
                  photo: 'assets/images/user_profile.jpg',
                  name: '이름',
                  latest: '테스트',
                  previewTapped: () => onMessagePreviewClicked(index),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
