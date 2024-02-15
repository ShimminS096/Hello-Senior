import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';

class ManagerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? actionTap;
  final Widget? actionchild;
  final double size;

  final String? title;

  const ManagerAppBar({
    Key? key,
    this.actionTap,
    this.actionchild,
    this.title,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          title: title != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              : null,
          iconTheme: const IconThemeData(size: 30),
          scrolledUnderElevation: 0,
          backgroundColor: MyColor.myBackground,
          actions: _buildActions(),
        ),
      ],
    );
  }

  List<Widget> _buildActions() {
    List<Widget> actions = [];

    if (actionTap != null && actionchild != null) {
      actions.add(
        InkWell(
          onTap: actionTap!,
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: actionchild!,
          ),
        ),
      );
    }
    return actions;
  }

  @override
  Size get preferredSize => Size.fromHeight(size);
}
