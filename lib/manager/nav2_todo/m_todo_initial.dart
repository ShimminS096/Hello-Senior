import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';
import 'package:knockknock/manager/nav2_todo/m_todo_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerTodoInitial extends StatefulWidget {
  final int numberofSeniors;
  final String currentUserUID; // currentUser의 UID를 저장할 변수 추가

  const ManagerTodoInitial({
    Key? key,
    required this.numberofSeniors,
    required this.currentUserUID, // 생성자에 currentUserUID 추가
  }) : super(key: key);

  @override
  State<ManagerTodoInitial> createState() => _ManagerTodoInitialState();
}

class _ManagerTodoInitialState extends State<ManagerTodoInitial> {
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

  Future<List<String>> _getSeniorUIDs() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserID) // 현재 사용자의 UID 사용
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final seniorUIDs = List<String>.from(data['seniorUIDs']);
        return seniorUIDs;
      }
    } catch (e) {
      print("Error getting seniorUIDs: $e");
    }

    return []; // 오류 발생 시 빈 배열 반환
  }

  Future<String> _getSeniorName(String seniorUID) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(seniorUID)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final seniorName = data['seniorName'] as String;
        return seniorName;
      }
    } catch (e) {
      print("Error getting senior name: $e");
    }

    return 'Unknown'; // 기본값으로 Unknown을 반환
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _getSeniorUIDs(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const Text('Error');
        }

        final seniorUIDs = snapshot.data!;

        return Scaffold(
          backgroundColor: MyColor.myBackground,
          appBar: const ManagerAppBar(
            title: "할 일",
            size: 95,
          ),
          body: Scrollbar(
            controller: _scrollController,
            trackVisibility: true,
            thumbVisibility: true,
            thickness: 5,
            radius: const Radius.circular(20),
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: seniorUIDs.length,
              itemBuilder: (BuildContext context, int index) {
                final seniorUID = seniorUIDs[index];

                return FutureBuilder<String>(
                  future: _getSeniorName(seniorUID),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text('Error');
                    }

                    final seniorName = snapshot.data ?? 'Unknown';

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0,
                          ),
                          child: ToDoBox(
                            name: seniorName,
                            seniorUID: seniorUID,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
