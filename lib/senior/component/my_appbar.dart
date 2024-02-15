import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? leadingText;
  final String? actionText;
  final VoidCallback? leadingCallback;
  final VoidCallback? actionCallback;
  final double? myLeadingWidth;

  const MyAppBar({
    Key? key,
    this.myLeadingWidth,
    this.leadingText,
    this.actionText,
    this.leadingCallback,
    this.actionCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(size: 30),
      backgroundColor: const Color(0xffEDEDF4),
      leadingWidth: _buildLeading() != null ? myLeadingWidth : null,
      leading: _buildLeading(),
      actions: _buildActions(),
    );
  }

  Widget? _buildLeading() {
    if (leadingText != null && leadingCallback != null) {
      return TextButton(
        onPressed: leadingCallback,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              leadingText!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
            ),
          ),
        ),
      );
    } else {
      return null;
    }
  }

  List<Widget> _buildActions() {
    List<Widget> actions = [];

    if (actionText != null && actionCallback != null) {
      actions.add(
        TextButton(
          onPressed: actionCallback,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Center(
              child: Text(
                actionText!,
                style: const TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return actions;
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
