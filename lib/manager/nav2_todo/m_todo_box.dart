import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/nav2_todo/m_todo_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String currentUserID = auth.currentUser!.uid;

class ToDoBox extends StatefulWidget {
  final String name;
  final String seniorUID;

  const ToDoBox({Key? key, required this.name, required this.seniorUID})
      : super(key: key);

  @override
  State<ToDoBox> createState() => _ToDoBoxState();
}

class _ToDoBoxState extends State<ToDoBox> {
  List<String> todoList = [];
  TextEditingController todoController = TextEditingController();
  late ScrollController _scrollController;
  bool _isAddingTodo = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _getTodos();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _getTodos() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('todo_list')
          .doc(currentUserID)
          .collection(widget.seniorUID) // seniorUID에 대한 할 일 목록 가져오기
          .doc('todos')
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final todos = List<String>.from(data['todo']);
        setState(() {
          todoList = todos;
        });
      }
    } catch (e) {
      print("Error getting todos: $e");
    }
  }

  void toggleTodoInput() {
    setState(() {
      _isAddingTodo = !_isAddingTodo;
      if (!_isAddingTodo) {
        todoController.clear();
      }
    });
  }

  void editTodo(int index, String editedTodo) {
    setState(() {
      todoList[index] = editedTodo;
    });
  }

  void addTodo() {
    String todo = todoController.text;
    if (todo.isNotEmpty) {
      try {
        final currentUserUID = currentUserID;
        final seniorUID = widget.seniorUID;

        FirebaseFirestore.instance
            .collection('todo_list')
            .doc(currentUserUID)
            .collection(seniorUID)
            .doc('todos')
            .update({
          'todo': FieldValue.arrayUnion([todo]),
        });

        setState(() {
          todoList.add(todo);
          todoController.clear();
        });
      } catch (e) {
        print("Error adding todo: $e");
      }
    }
    toggleTodoInput();
  }

  void deleteTodo(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 250,
      decoration: BoxDecoration(
        color: MyColor.myWhite,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    toggleTodoInput();
                  },
                  icon: const Icon(Icons.add_rounded),
                  iconSize: 30,
                  padding: const EdgeInsets.all(0),
                  color: MyColor.myMediumGrey,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _isAddingTodo
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: todoController,
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: MyColor.myMediumGrey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: MyColor.myBlue),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                            onSubmitted: (value) {
                              addTodo();
                            },
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: List.generate(
                    todoList.length,
                    (index) => TodoItem(
                      text: todoList[index],
                      seniorUID: widget.seniorUID,
                      onEdit: (editedTodo) {
                        editTodo(index, editedTodo);
                      },
                      onDelete: () {
                        deleteTodo(index);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
