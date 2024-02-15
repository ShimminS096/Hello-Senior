import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';
import 'package:knockknock/manager/nav2_todo/m_todo_box.dart';

class ManagerTodoInitial extends StatefulWidget {
  final int numberofSeniors;
  const ManagerTodoInitial({super.key, required this.numberofSeniors});

  @override
  State<ManagerTodoInitial> createState() => _ManagerTodoInitialState();
}

class _ManagerTodoInitialState extends State<ManagerTodoInitial> {
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

  @override
  Widget build(BuildContext context) {
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
          itemCount: numberofSeniors,
          itemBuilder: (BuildContext context, int index) {
            return const Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: ToDoBox(
                    name: '이름입력',
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
