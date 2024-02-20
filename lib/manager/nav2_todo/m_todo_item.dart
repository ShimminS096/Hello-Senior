import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class TodoItem extends StatefulWidget {
  final String text;
  final Function(String) onEdit;
  final VoidCallback onDelete;
  final String seniorUID;

  const TodoItem({
    Key? key,
    required this.text,
    required this.onEdit,
    required this.onDelete,
    required this.seniorUID,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late TextEditingController editController;
  bool _isEditing = false;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    editController = TextEditingController(text: widget.text);
  }

  Future<void> _updateToDoInFirestore(String newText) async {
    try {
      final currentUserUID = 'OI75iw9Z1oTlV2EyyL8C'; //현재 user의 UID로 수정
      final seniorUID = widget.seniorUID;

      await FirebaseFirestore.instance
          .collection('todo_list')
          .doc(currentUserUID)
          .collection(seniorUID)
          .doc('todos')
          .set({
        'todo': FieldValue.arrayUnion([newText]),
      });
    } catch (e) {
      print("Error updating todo: $e");
    }
  }

  Future<void> _deleteTodoInFirestore(String todoToRemove) async {
    try {
      final currentUserUID =
          'B0z8CS40r7dtESumdeohkL0Rqyk2'; // 현재 사용자의 UID로 수정해야 함
      final seniorUID = widget.seniorUID;

      await FirebaseFirestore.instance
          .collection('todo_list')
          .doc(currentUserUID)
          .collection(seniorUID)
          .doc('todos')
          .update({
        'todo': FieldValue.arrayRemove([todoToRemove]),
      });

      widget.onDelete(); // UI에서 선택한 todo 제거
    } catch (e) {
      print("Error deleting todo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: _isDone,
          activeColor: MyColor.myBlue,
          onChanged: (bool? value) {
            setState(() {
              _isDone = value!;
            });
          },
        ),
        _isEditing
            ? Expanded(
                child: TextField(
                  controller: editController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColor.myMediumGrey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColor.myBlue),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                  onSubmitted: (value) async {
                    await _updateToDoInFirestore(value);
                    widget.onEdit(value);
                    setState(() {
                      _isEditing = false;
                    });
                  },
                ),
              )
            : GestureDetector(
                onTap: () {
                  setState(() {
                    _isEditing = true;
                  });
                },
                child: SizedBox(
                  width: 290,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 22,
                      decoration: _isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ),
        IconButton(
          onPressed: () {
            widget.onDelete;
            _deleteTodoInFirestore(widget.text);
          },
          icon: const Icon(Icons.delete),
          iconSize: 25,
          padding: const EdgeInsets.all(0),
          color: MyColor.myMediumGrey,
        ),
      ],
    );
  }
}
